PRODUCT_NAME := CTA22Gacha
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
SWIFT_RUN := swift run -c release --package-path Tools

xcodegen: 
	@mint run yonaskolb/XcodeGen xcodegen generate --use-cache
setup:
	make xcodegen
	make run-swiftgen
	open ./${PROJECT_NAME}
open:
	open ./${PROJECT_NAME}
run-swiftgen:
	$(SWIFT_RUN) swiftgen

