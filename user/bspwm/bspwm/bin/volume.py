import subprocess

def get_volume():
    try:
        volume = subprocess.check_output(["pamixer", "--get-volume"]).decode().strip()
        muted = subprocess.check_output(["pamixer", "--get-mute"]).decode().strip()
        return [volume, muted[0]=='t']
    except subprocess.CalledProcessError:
        return None

# Call the function to get the volume
ret = get_volume()
if ret is not None:
    content = ""
    volume, muted = ret
    if muted:
        content = " "
    else:
        content = " "
    content += volume + "%"
    print(content, flush=True)
else:
    print("?%")
