import os
import ssl
import subprocess
import threading
import base64
from flask import Flask, send_from_directory
from flask_cors import CORS
from requests import Session, packages
from requests.adapters import HTTPAdapter
from requests.auth import HTTPBasicAuth
from flask import Flask

# Custom adapter for HTTPS requests that ignores SSL certificate verification
class InsecureRequestAdapter(HTTPAdapter):
    def init_poolmanager(self, *args, **kwargs):
        context = kwargs.get('ssl_context')
        if context:
            kwargs['ssl_context'] = self._create_unverified_context()
        return super().init_poolmanager(*args, **kwargs)

    @staticmethod
    def _create_unverified_context():
        context = ssl.create_default_context()
        context.check_hostname = False
        context.verify_mode = ssl.CERT_NONE
        return context

# Function to get the live stream from a Hololens device
def get_hololens_stream(ip_address, username, password):
    url = f'https://{ip_address}/api/holographic/stream/live.mp4'
    headers = {'Content-Type': 'application/json'}

    session = Session()
    session.mount('https://', InsecureRequestAdapter())  # Use the custom adapter for HTTPS requests
    packages.urllib3.disable_warnings(category=packages.urllib3.exceptions.InsecureRequestWarning)  # Disable warnings related to insecure SSL connections

    try:
        response = session.get(url, headers=headers, auth=HTTPBasicAuth(username, password), stream=True, verify=False)
        return response
    except requests.exceptions.RequestException as e:
        print(f'Error: {e}')
        return None

# Function to convert a live stream to HLS format using FFmpeg
def convert_to_hls(username, password, input_url, output_path):
    command = [
        'C:/Users/Student/Downloads/ffmpeg-6.0-essentials_build/ffmpeg-6.0-essentials_build/bin/ffmpeg.exe',
        '-user_agent', 'Mozilla/5.0',
        '-headers', f"Authorization: Basic {base64.b64encode(f'{username}:{password}'.encode()).decode()}",
        '-i', input_url,
        '-codec:v', 'libx264',
        '-profile:v', 'main',
        '-preset:v', 'medium',
        '-g', '30',
        '-hls_time', '2',
        '-hls_list_size', '5',
        '-hls_flags', 'delete_segments',
        '-hls_segment_filename', f'{output_path}/segment_%03d.ts',
        f'{output_path}/stream.m3u8'
    ]

    try:
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")


app = Flask(__name__)
CORS(app)
packages.urllib3.disable_warnings(category=packages.urllib3.exceptions.InsecureRequestWarning)

output_path = 'hls_output'

@app.route('/stream.m3u8')
def stream_m3u8():
    return send_from_directory(output_path, 'stream.m3u8', conditional=True)

@app.route('/<path:filename>')
def stream_segment(filename):
    return send_from_directory(output_path, filename, conditional=True)

def start_stream():
    username = 'teklab'  # Username
    password = 'mac123456'  # Password
    input_url = 'http://158.37.233.195/api/holographic/stream/live.mp4' # Change to headset IP
    output_path = 'hls_output'

    if not os.path.exists(output_path):
        os.makedirs(output_path)

    convert_to_hls(username, password, input_url, output_path)

if __name__ == '__main__':
    stream_thread = threading.Thread(target=start_stream)
    stream_thread.start()
    app.run(host='0.0.0.0', port=5000, ssl_context=('cert.pem', 'key.pem'))

