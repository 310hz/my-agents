default:
    @just --list

# entity/skills 配下のスキルをグローバルにインストールする
install:
    npx skills add ./entity/skills -g
