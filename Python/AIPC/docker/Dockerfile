FROM python:3.12.7
WORKDIR /aipc

# 必要なシステムパッケージとNoto Sans CJK JPをインストール
RUN apt-get update && apt-get install -y \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
    build-essential \
    fonts-noto-cjk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
COPY . /aipc
CMD ["python", "AIPC_CUI.py"]