#! /bin/zsh

swift package --allow-writing-to-directory ./docs \
    generate-documentation --target PicoCSS --output-path ./docs \
    --transform-for-static-hosting --hosting-base-path elementary-picocss
