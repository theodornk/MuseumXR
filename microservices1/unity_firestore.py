import os
from flask import Flask, jsonify, request
from flask_socketio import SocketIO, emit
import firebase_admin
from firebase_admin import credentials, firestore

# DET ER DENNE SOM FUNKER, IKKE "XX1.py"
app = Flask(__name__)
socketio = SocketIO(app)

# Initialize the Firebase Admin SDK
cred = credentials.Certificate("C:/Users/Student/Documents/livestreamServer/firebase-adminsdk.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

# Endpoint to get the active and reset values for a specific user and exhibition
@app.route("/get_latest_values", methods=["GET"])
def get_latest_values():
    user_id = request.args.get("user_id")
    exhibition_id = request.args.get("exhibition_id")

    if not user_id or not exhibition_id:
        return jsonify({"error": "Missing user_id or exhibition_id"}), 400

    try:
        doc_ref = db.collection("users").document(user_id).collection("exhibitions").document(exhibition_id)
        doc = doc_ref.get()

        if doc.exists:
            data = doc.to_dict()
            active = data.get("active", False)
            reset = data.get("reset", False)
            return jsonify({"active": active, "reset": reset}), 200
        else:
            return jsonify({"error": "Document not found"}), 404
    except Exception as e:
        print(e)
        return jsonify({"error": "An error occurred while retrieving data"}), 500

@socketio.on('connect')
def handle_connect():
    print('Unity app connected')

@socketio.on('disconnect')
def handle_disconnect():
    print('Unity app disconnected')

@socketio.on('get_values')
def handle_get_values(message):
    user_id = message.get("user_id")
    exhibition_id = message.get("exhibition_id")

    if user_id and exhibition_id:
        try:
            doc_ref = db.collection("users").document(user_id).collection("exhibitions").document(exhibition_id)
            doc = doc_ref.get()

            if doc.exists:
                data = doc.to_dict()
                active = data.get("active", False)
                reset = data.get("reset", False)
                socketio.emit('update_values', {
                    "user_id": user_id,
                    "exhibition_id": exhibition_id,
                    "active": active,
                    "reset": reset
                })
                print(f"Emitted update_values to {user_id} and {exhibition_id} with active={active} and reset={reset}")
            else:
                print("Document not found")
        except Exception as e:
            print(e)

if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)), debug=True)