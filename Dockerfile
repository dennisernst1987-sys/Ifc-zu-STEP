FROM continuumio/miniconda3:latest

WORKDIR /app

# Conda-Pakete (IfcOpenShell + pythonocc brauchen Conda)
RUN conda install -y -c conda-forge \
    ifcopenshell \
    pythonocc-core \
    && conda clean -afy

# Python-Pakete
COPY requirements.txt .
RUN pip install --no-cache-dir fastapi uvicorn[standard] python-multipart

COPY main.py .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
