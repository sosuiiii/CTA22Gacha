PRODUCT_NAME := GachaApp
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
SWIFT_RUN := swift run -c release --package-path Tools

xcodegen: 
	@mint run yonaskolb/XcodeGen xcodegen generate --use-cache
setup: 
	mkdir -p GachaApp/UIResource/Generated/{Color,Image,Localizable}
	make run-swiftgen
	make xcodegen
	open ./${PROJECT_NAME}
open:
	open ./${PROJECT_NAME}
run-swiftgen:
	$(SWIFT_RUN) swiftgen

