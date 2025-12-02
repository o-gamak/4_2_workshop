[![Python](https://img.shields.io/badge/Python-3.11-blue?logo=python&logoColor=white)](#)
[![Pandas](https://img.shields.io/badge/Pandas-2.2+-blue?logo=pandas&logoColor=white)](#)
[![CatBoost](https://img.shields.io/badge/CatBoost-1.2+-orange?logo=catboost&logoColor=white)](#)
[![XGBoost](https://img.shields.io/badge/XGBoost-2.0+-orange)](#)
[![LightGBM](https://img.shields.io/badge/LightGBM-4.3+-green)](#)
[![SHAP](https://img.shields.io/badge/SHAP-0.50-success)](#)
[![scikit--learn](https://img.shields.io/badge/scikit--learn-1.4-blue)](#)
[![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange?logo=jupyter)](#)
[![ROC-AUC](https://img.shields.io/badge/ROC--AUC-0.8275-brightgreen)](#)


# Прогнозирование покупки клиента в ближайшие 90 дней

**Задача маркетинга:** определить, кто из клиентов маркетплейса совершит покупку в течение следующих 90 дней.

**Описание данных**

1. apparel-purchases — история покупок:

* client_id — идентификатор пользователя
* quantity — количество товаров
* price — цена товара
* category_ids — категории товара
* date — дата покупки
* message_id — идентификатор сообщения рассылки

2. apparel-messages — история рекламных рассылок:

* bulk_campaign_id — идентификатор кампании
* client_id — идентификатор пользователя
* message_id — идентификатор сообщения
* event — тип действия (send, click, open, purchase и др.)
* channel — канал рассылки (email, mobile_push)
* date — дата события

3. apparel-target_binary — целевая переменная:

* client_id — идентификатор пользователя
* target — совершит покупку в течение 90 дней (1/0)

**Решение:** модель на основе CatBoostClassifier с качеством **ROC-AUC = 0.8275** на отлаженной тестовой выборке.

---

### Главные результаты
- Сгенерировано **44 осмысленных признака** на основе истории покупок и поведения в рассылках (RFM-метрики, CTR и open_rate за 30/60/90 дней, recency, monetary, давность активности, категорийные предпочтения и др.)
- Достигнуто качество **ROC-AUC = 0.8275** на отложенной тестовой выборке (прирост +327 пунктов к Dummy-бейзлайну)
- Полная интерпретируемость модели через **SHAP-анализ** — все ключевые факторы предсказания логичны и подтверждены бизнес-смыслом
- Реализован полностью воспроизводимый пайплайн: основной вариант — работа с локальными данными, запасной — автоматическая загрузка через Google Drive (`gdown`)
- Проект структурирован, снабжён `requirements.txt`, `.gitignore` и подробным README — готов к публикации и демонстрации


### Результаты моделей

| Модель              | CV ROC-AUC | Test ROC-AUC | Время обучения |
|---------------------|------------|--------------|----------------|
| **CatBoost**        | **0.8147** | **0.8275**   | 41 сек         |
| XGBoost             | 0.8145     | 0.8266       | 4 сек          |
| LightGBM            | 0.8055     | 0.8257       | 1 мин 09 сек   |
| Dummy (бейзлайн)    | 0.5000     | 0.5000       | —              |

**Выбрана CatBoost** — лучшее качество + встроенная обработка категорий

### Ключевые инсайты из SHAP-анализа
- Самый мощный драйвер ctr_30d (клики по рассылкам за последние 30 дней)
- Лояльные «старожилы» покупают чаще новичков
- Высокий средний чек негативный сигнал на 90 дней («киты» покупают редко)
- Высокая открываемость писем без кликов признак холодной аудитории

### Ожидаемый бизнес-эффект
| Направление                        | Эффект                                           |
|------------------------------------|--------------------------------------------------|
| Конверсия email/push рассылок      | рост в 3–5 раз при отправке топ-20% по скорингу  |
| Снижение спама и оттока            | точечная коммуникация вместо массовых рассылок   |
| Рост выручки                       | реактивация + триггерные кампании                |
| Экономия маркетингового бюджета    | исключение неэффективных контактов               |

### Как запустить проект

```bash
git clone https://github.com/o-gamak/4_2_workshop
cd 4_2_workshop
pip install -r requirements.txt
jupyter notebook notebook.ipynb
```

### Структура проекта
```
├── gam.ipynb              # основной ноутбук с полным пайплайном
├── requirements.txt       # зафиксированные зависимости
└──  README.md              # этот файл
```

### Технологии

Python 3.11
Pandas, NumPy, Matplotlib, Seaborn
CatBoost, XGBoost, LightGBM
SHAP, scikit-learn, phik, gdown

Автор: [Ilya Gamayunov/ o_gamak]
Год: 2025
Telegram: o_gam