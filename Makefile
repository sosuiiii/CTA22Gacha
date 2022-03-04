PRODUCT_NAME := CTA22Gacha
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj

xcodegen: 
	@mint run yonaskolb/XcodeGen xcodegen generate --use-cache
setup:
	make xcodegen
	open ./${PROJECT_NAME}
open:
	open ./${PROJECT_NAME}

