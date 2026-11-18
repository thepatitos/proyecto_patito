PYTHON = python3
SCRIPT = patito_entrenador.py
PATCHER = parchear.py

all: patch
	@echo "========================================="
	@echo "  Proyecto Patito - Entrenador listo"
	@echo "  Puedes hacer: make run"
	@echo "========================================="

patch:
	@$(PYTHON) $(PATCHER)

run: patch
	@$(PYTHON) $(SCRIPT)

install:
	@chmod +x install_header.sh
	@./install_header.sh

clean:
	@rm -rf __pycache__ *.pyc

.PHONY: all patch run install clean
