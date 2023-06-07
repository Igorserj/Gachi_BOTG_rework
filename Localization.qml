import QtQuick 2.15

QtObject {
    property string currentLanguage: "Українська"
    readonly property var languages: ["Українська", "English", "Русский"]

    readonly property var homeButtonNames: [[["Розпочати гру", "Налаштування", "Вихід"], ["Нова гра", "Продовжити", "Назад"]] ,
                                            [["Start game", "Settings", "Quit game"], ["New game", "Continue", "Back"]] ,
                                            [["Играть", "Настройки", "Выход"], ["Новая игра", "Продолжить", "Назад"]]][languages.indexOf(currentLanguage)]

    readonly property var settingsFullScreenTrue: ["На повний екран", "Go fullscreen", "На полный экран"][languages.indexOf(currentLanguage)]
    readonly property var settingsFullScreenFalse: ["У віконний режим", "Go windowed", "В оконный режим"][languages.indexOf(currentLanguage)]
    readonly property var settingsSave: ["Зберегти", "Save", "Сохранить"][languages.indexOf(currentLanguage)]
    readonly property var settingsFPSon: ["Відобразити лічильник кадрів", "Show frames counter", "Показать счётчик кадров"][languages.indexOf(currentLanguage)]
    readonly property var settingsFPSoff: ["Приховати лічильник кадрів", "Hide frames counter", "Скрыть счётчик кадров"][languages.indexOf(currentLanguage)]

    readonly property var menuButtonNames: [["Продовжити", "Головне меню", "Вихід"],
                                            ["Continue", "Main menu", "Quit"],
                                            ["Продолжить", "Главное меню", "Выход"]][languages.indexOf(currentLanguage)]
}
