#!/usr/bin/env sh

. ~/.nvm/nvm.sh && nvm use

set -e
case $1 in
    install)
        echo node: $(node -v) 
        echo npm: $(npm -v) 
        npm install  
        ;;
    lint:report)
        npm run lint:report  
        ;;
    flow)
        npm run flow
        ;;
    test)
        npm run test  
        ;;
    build)
        npm run build  
        ;;
    semantic-release)
        env
        npx semantic-release --branch $BRANCH_NAME
        ;;
    semantic-release-dry-run)
        env
        npx semantic-release --branch $BRANCH_NAME --dry-run
        ;;
    whitesource)
        npm run whitesource
        ;;
    *)
        echo "Unknown task!!"
        exit 1
esac
