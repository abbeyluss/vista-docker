# Use Amazon Linux image
FROM amazonlinux:2023  

# Set environment variables
# Note: Python 3.13 currently cannot be downloaded with dnf, should be available in the future though
ENV PORT=80
ENV PYTHON\_VERSION\=3.12 

EXPOSE ${PORT} 

RUN --mount=type=cache,target=/var/cache/dnf \
    dnf -y update && \
    dnf install -y python${PYTHON_VERSION} python${PYTHON_VERSION}-pip shadow-utils git-all findutils awscli tar && \
    update-alternatives --install /usr/bin/python python /usr/bin/python${PYTHON_VERSION} 20 && \
    update-alternatives --set python /usr/bin/python${PYTHON_VERSION} && \
    dnf clean all

WORKDIR .  

# Currently irrelevant but keeping for potential future use
COPY requirements.txt ./ 

RUN python -m pip install --upgrade pip 

RUN pip install --no-cache-dir -r requirements.txt  

COPY . .  

# Necessary imports for python 
RUN pip install -U Pillow && pip install -U google-generativeai && pip install -U pandas && \
pip install -U Logger && pip install -U datetime

# Add startup script
COPY sys_main_gemini.py /usr/local/bin/sys_main_gemini.py
RUN chmod +x /usr/local/bin/sys_main_gemini.py 

ENTRYPOINT ["sys_main_gemini.py" ] 