#!/usr/bin/env sh

cd bundle
if [[ $? -eq 1 ]]; then
	echo No bundle directory found
	exit 1
fi

function say() {
    echo '\n\033[1;31m'$*'\033[0m'
}

say In bundle directory

say Cloning vim-javascript...
git clone https://github.com/pangloss/vim-javascript.git

say Cloning Tagbar...
git clone https://github.com/majutsushi/tagbar.git

say Cloning Dokuwiki...
git clone https://github.com/nblock/vim-dokuwiki.git

say Cloning OpenBrowser...
git clone https://github.com/tyru/open-browser.vim

say Cloning ActionScript syntax...
git clone https://github.com/vim-scripts/actionscript.vim--Leider.git

say Cloning Elixir...
git clone https://github.com/elixir-lang/vim-elixir.git

say Cloning NERDTreeTabs
git clone https://github.com/jistr/vim-nerdtree-tabs.git

say Cloning zoom.vim...
git clone https://github.com/vim-scripts/zoom.vim.git

say Cloning Vim Erlang...
git clone https://github.com/oscarh/vimerl.git

say Cloning Perl Omni...
git clone https://github.com/c9s/perlomni.vim.git

#say Cloning Gundo...
#git clone http://github.com/sjl/gundo.vim.git

say Cloning Rooter...
git clone https://github.com/airblade/vim-rooter.git

say Cloning Unicode Completion...
git clone https://github.com/chrisbra/unicode.vim.git

say Cloning F# Runtime...
git clone https://github.com/kongo2002/fsharp-vim.git

say Cloning Indent Text Objects...
git clone https://github.com/michaeljsmith/vim-indent-object.git

say Cloning Column Text Objects...
git clone https://github.com/coderifous/textobj-word-column.vim.git

say Cloning Fugitive \(Git\)...
git clone https://github.com/tpope/vim-fugitive.git

say Cloning Ack...
git clone https://github.com/mileszs/ack.vim.git

say Cloning Git Gutter...
git clone git://github.com/airblade/vim-gitgutter.git

say Cloning fireplace and friends \(Clojure\)...
git clone git://github.com/tpope/vim-fireplace.git
git clone git://github.com/tpope/vim-classpath.git
git clone git://github.com/guns/vim-clojure-static.git
git clone git@github.com:guns/vim-clojure-highlight.git
# BREAKS HORRIFICALLY
git clone git@github.com:tpope/vim-leiningen.git
git clone git@github.com:tpope/vim-projectionist.git

say Cloning Rainbow Parentheses...
git clone git@github.com:kien/rainbow_parentheses.vim.git

say Cloning zencoding...
git clone https://github.com/mattn/zencoding-vim.git

say Cloning Cucumber...
git clone git@github.com:tpope/vim-cucumber.git

say Cloning Instant Markdown...
git clone git@github.com:suan/vim-instant-markdown.git

say Cloning Puppet...
git clone git@github.com:rodjek/vim-puppet.git

say Cloning unstack...
git clone https://github.com/mattboehm/vim-unstack.git

say Cloning JSON...
git clone https://github.com/elzr/vim-json.git

say Cloning paredit...
hg clone ssh://hg@bitbucket.org/kovisoft/paredit

say Cloning Salt Stack...
git clone git@github.com:saltstack/salt-vim.git

say Cloning CtrlP...
git clone git@github.com:kien/ctrlp.vim.git

say Cloning vim-repeat...
git clone git@github.com:tpope/vim-repeat.git

say Cloning vim-sexp...
git clone git@github.com:guns/vim-sexp.git

say Cloning floobits...
git clone https://github.com/Floobits/floobits-vim

say Cloning clang_complete...
git clone git@github.com:Rip-Rip/clang_complete.git

say "Cloning vimproc (N.B. requires compile!)"
git clone https://github.com/Shougo/vimproc.vim.git ~/.vim/bundle/vimproc.vim

say Cloning VimShell...
git clone git@github.com:Shougo/vimshell.vim.git

say Cloning Solarized...
git clone git://github.com/altercation/vim-colors-solarized.git

say Cloning Haskell Stuff...
git clone git@github.com:lukerandall/haskellmode-vim.git

say Cloning Goyo...
git clone git@github.com:junegunn/goyo.vim.git

say Cloning limelight...
git clone git@github.com:junegunn/limelight.vim.git

say Cloning Refheap...
git clone git@github.com:Raynes/refheap.vim.git

say Cloning Undo Tree...
git@github.com:mbbill/undotree.git

say Done.
