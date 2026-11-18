PYTHON = python3 -B
APP = patito_entrenador.py
GENERATOR = generar_banco.py
HEADER_SCRIPT = install_header.sh
DB = banco.dat
DIST_NAME = patito-entrenador-v1.0.0.tar.gz

.PHONY: all install-header doctor run clean fclean dist

all: install-header $(DB) doctor
	@echo "[OK] Patito-entrenador listo. Ejecuta: make run"

install-header:
	@./$(HEADER_SCRIPT) >/dev/null

$(DB):
	@if [ -f "$(GENERATOR)" ]; then \
		$(PYTHON) $(GENERATOR) >/dev/null; \
	elif [ ! -f "$(DB)" ]; then \
		echo "[ERROR] Falta $(DB) y no existe $(GENERATOR)." >&2; \
		exit 1; \
	fi

doctor:
	@$(PYTHON) $(APP) --doctor >/dev/null || { $(PYTHON) $(APP) --doctor; exit 1; }

run:
	@$(PYTHON) $(APP)

clean:
	@rm -rf subject .tmp_exec __pycache__ .patito.lock

fclean: clean
	@rm -rf rendu rendu_backup progreso.json .repaso.dat $(DIST_NAME)

dist: clean
	@tar --exclude='./rendu' --exclude='./rendu_backup' --exclude='./subject' \
	     --exclude='./progreso.json .repaso.dat' --exclude='./.patito.lock' \
	     --exclude='./.tmp_exec' --exclude='./$(GENERATOR)' \
	     --exclude='./__pycache__' --exclude='./$(DIST_NAME)' \
	     -czf $(DIST_NAME) .
	@echo "[OK] Paquete creado: $(DIST_NAME)"
