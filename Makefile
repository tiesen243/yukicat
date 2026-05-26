TARGET_DIR = target

BUILD_DEV_DIR = $(TARGET_DIR)/debug
BUILD_PROD_DIR = $(TARGET_DIR)/release

TARGET_DEV = $(BUILD_DEV_DIR)/Yukicat
TARGET_PROD = $(BUILD_PROD_DIR)/Yukicat

define DESKTOP_CONTENT
[Desktop Entry]
Type=Application
Name=Yukicat
Comment=Yukicat Application Launcher
Exec=Yukicat
Icon=Yukicat
Categories=Utility;
Terminal=false
endef
export DESKTOP_CONTENT

.PHONY: all clean dev prod setup_dev setup_prod

all: dev

setup_dev:
	@mkdir -p $(BUILD_DEV_DIR)
	@if [ ! -f "$(BUILD_DEV_DIR)/Makefile" ]; then \
		cd $(BUILD_DEV_DIR) && cmake -DCMAKE_BUILD_TYPE=Debug -Wno-dev --no-warn-unused-cli ../..; \
	fi
	@if [ -f "$(BUILD_DEV_DIR)/compile_commands.json" ] && [ ! -f "compile_commands.json" ]; then \
		ln -s $(BUILD_DEV_DIR)/compile_commands.json compile_commands.json; \
	fi

dev: setup_dev
	@echo "=================================================="
	@echo "🛠️  [DEV] Compiling Yukicat inside $(BUILD_DEV_DIR)..."
	@echo "=================================================="
	@cd $(BUILD_DEV_DIR) && cmake --build .

setup_prod:
	@echo "🧹 Cleaning up old release caches..."
	@rm -rf $(BUILD_PROD_DIR)
	@mkdir -p $(BUILD_PROD_DIR)
	@cd $(BUILD_PROD_DIR) && cmake -DCMAKE_BUILD_TYPE=Release -Wno-dev --no-warn-unused-cli ../..

prod: setup_prod
	@echo "=================================================="
	@echo "📦 [PROD] Compiling Yukicat inside $(BUILD_PROD_DIR)..."
	@echo "=================================================="
	@cd $(BUILD_PROD_DIR) && cmake --build .
	@echo "📦 Packaging standalone bundle directly inside $(BUILD_PROD_DIR)..."
	
	@if [ "$$(uname)" = "Linux" ]; then \
		echo "🐧 Scanning dependencies on Linux using linuxdeploy..."; \
		if command -v linuxdeploy >/dev/null 2>&1; then \
			echo "📝 Generating temporary desktop file and icon..."; \
			if [ -f "$(CURDIR)/assets/icon.png" ]; then \
				cp "$(CURDIR)/assets/icon.png" $(BUILD_PROD_DIR)/Yukicat.png; \
			else \
				echo "⚠️  Warning: $(CURDIR)/assets/icon.png not found! Using empty icon."; \
				touch $(BUILD_PROD_DIR)/Yukicat.png; \
			fi; \
			echo "$$DESKTOP_CONTENT" > $(BUILD_PROD_DIR)/Yukicat.desktop; \
			cd $(BUILD_PROD_DIR) && QML_SOURCES_PATHS=$(CURDIR)/src NO_STRIP=1 linuxdeploy --appdir AppDir --executable Yukicat --desktop-file=Yukicat.desktop --icon-file=Yukicat.png --plugin qt --output appimage; \
			rm -rf $(BUILD_PROD_DIR)/AppDir $(BUILD_PROD_DIR)/Yukicat.desktop $(BUILD_PROD_DIR)/Yukicat.png; \
		else \
			echo "⚠️  Note: 'linuxdeploy' is not installed. Collecting base .so files into target/release/lib..."; \
			mkdir -p $(BUILD_PROD_DIR)/lib; \
			ldd $(TARGET_PROD) | grep "=> /" | awk '{print $$3}' | xargs -I '{}' cp -v '{}' $(BUILD_PROD_DIR)/lib/; \
		fi \
	elif [ "$$(uname)" = "Darwin" ]; then \
		echo "🍎 Packaging .app on macOS using macdeployqt..."; \
		macdeployqt $(BUILD_PROD_DIR)/Yukicat.app -dmg; \
	else \
		echo "🪟 If running on Windows, please run windeployqt inside target/release/."; \
	fi
	@echo "✨ Done! The standalone bundle is ready inside: ./$(BUILD_PROD_DIR)"

clean:
	@echo "🧹 Removing target directory..."
	@rm -rf $(TARGET_DIR) compile_commands.json
	@echo "✨ Clean up finished!"
