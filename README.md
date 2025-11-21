# InformaSinn

This is the source code of _InformaSinn_ (as in **_Information_** and **_Sinn_**, translated Information-Sense), an educational website, where students are able to explore the relationship with _data_ and _information_. Made with ❤️ and ⚡️powered by [huggingface.co](https://huggingface.co/huihui-ai/Qwen2.5-14B-Instruct-abliterated-v2). 

## How to use
User enters a bunch of data e.g. numbers, emojis or descriptions and the program outputs appropriate information regarding this given data.

## Educational notes

With this tool, students are able to explore the relationship between everyday data (e.g. 👋-emoji) and the information they are holding (e.g. 👋 means greeting).

## Build

1. Checkout this Repository
2. Create an [account on huggingface](https://huggingface.co/) and an access token `read`.
3. Create an `.env`-file on your project root and add the line `HF_TOKEN=<your token here>` and `BASE_URL=<your base url>` respectively.
4. Run `flutter run web --dart-define-from-file=.env`
5. Enjoy 🎂

## Deploy by yourself

1. Run `flutter build web`
2. Upload the contents of the `build/web` folder to your webspace
3. Enjoy

## Further improvements

- enable user to choose model
- enable user to change language or interface
