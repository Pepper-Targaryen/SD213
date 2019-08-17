# Simple Grammar for Chinese
The project is based on `python` environment because we found that `Prolog` doesn't support Chinese so well. All the charactors in the files are encoded with `utf-8`.

In the file of the `dictionary.utf-8`, words are defined for the dictionary. One line for one word and an empty line to separate different types of words.

In the file of the `sentence.utf-8`, a normal Chinese sentence is defined here. The sentence will be splitted into words with the splitter defined in `MySplitter.py` and finally analysed with the interpreter defined in `MyCharty.py`.

If a word is not defined in the dictionary, the splitter will consider by default one Chinese charactor as a word. For example, if "*今天*" is not defined in the dictionary, then the splitted sentences for "*我今天在操场跑步*" will be "*我 今 天 在 操场 跑步*". 

## MySplitter
```console
python3 MySplitter.py dictionary.utf-8 sentence.utf-8 result.utf-8
```
* `dictionary.utf-8` is the file defining a dictionary of words
* `sentence.utf-8` is the file for sentences to be splitted
* `result.utf-8` is the file for the output of the splitted words

## MyCharty
```console
python3 MyCharty.py -g PSG3.txt -i result.utf-8
```
* `PSG3.txt` is the file for the grammar
* `result.utf-8` is the file containing the splitted sentence which will be analysed