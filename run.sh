#!/usr/bin/env bash
set -e

echo "Клонируем репозиторий..."
[ -d "4_2_workshop" ] || git clone https://github.com/o-gamak/4_2_workshop.git
cd 4_2_workshop

echo "Создаём виртуальное окружение..."
python3 -m venv venv 2>/dev/null || python -m venv venv

. venv/bin/activate 2>/dev/null || source venv/Scripts/activate 2>/dev/null || source venv/bin/activate

echo "Обновляем pip и ставим зависимости..."
pip install --upgrade pip > /dev/null
pip install -q -r requirements.txt

pip install -q click 2>/dev/null || true

echo ""
echo "Всё готово! Запускаем notebook.ipynb"
echo "Открой в браузере: http://localhost:8888"
echo ""

jupyter notebook notebook.ipynb