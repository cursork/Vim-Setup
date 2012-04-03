" Spell check comments

syn region sqlComment    start="{"  end="}" contains=sqlTodo,@Spell
syn match sqlComment     "--.*$" contains=sqlTodo,@Spell
syn sync ccomment sqlComment


