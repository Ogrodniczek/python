"------------------------------------
"
"         AUTOR: Piotr O.arowski
"           WWW: www.ozarowski.pl
"
"          PLIK: .vimrc
"        WERSJA: 2.2
"   MODYFIKACJA: .ro 21-06-2006 15:59
"
"------------------------------------

set nocompatible                " niekompatybilny z VI => w..cz bajery VIMa
set nobackup                    " nie trzymaj kopii zapasowych, u.ywaj wersji
set backspace=indent,eol,start
set viminfo='20,\"50            " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set browsedir=buffer            " To get the File / Open dialog box to default to the current file's directory
set pastetoggle=<F11>           " prze..czanie w tryb wklejania (nie b.dzie automatycznych wci.., ...)
set number                      " nie wy.wietlaj nr linii
setlocal number                 " pierwszy odpalony bufor ma nrki
set wildmenu                    " wy.wietlaj linie z menu podczas dope.niania
set showmatch                   " pokaz otwieraj.cy nawias gdy wpisze zamykaj.cy
set so=5                        " przewijaj juz na 5 linii przed ko.cem
set statusline=%y[%{&ff}]\ \ ASCII=\%03.3b,HEX=\%02.2B\ %=%m%r%h%w\ %1*%F%*\ %l:%v\ (%p%%)
set laststatus=2                " zawsze pokazuj lini. statusu
set fo=tcrqn                    " opcje wklejania (jak maja by. tworzone wci.cia itp.)
set hidden                      " nie wymagaj zapisu gdy przechodzisz do nowego bufora
set tags+=./stl_tags            " tip 931
set foldtext=MojFoldText()      " tekst po zwini.ciu zak.adki
set foldminlines=3              " minimum 3 linie aby powsta. fold
"set wildmode=longest:full      " dope.niaj jak w BASHu
"set cpoptions="A"
"set keymodel=startsel,stopsel  " zaznaczanie z shiftem
let php_sql_query = 1           " podkre.lanie sk.adni SQL w PHP
let php_htmlInStrings = 1       " podkre.lanie sk.adni HTML w PHP
let python_highlight_all = 1
set ts=4

if version >= 700
        set ofu=syntaxcomplete#Complete " Default to omni completion using the syntax highlighting files
        set spelllang=pl,en
"        set balloonexpr=BalloonExpr()  " tip 1149
endif


behave xterm

if &t_Co > 2 || has("gui_running")
        syntax on              " kolorowanie sk.adni
        set hlsearch           " zaznaczanie szukanego tekstu
        colorscheme POX                " domy.lny schemat koloróndif
if has("gui_running")
        set foldcolumn=2       " szeroko.. kolumny z zak.adkami
        set guioptions=abegimrLtT      " m.in: w..cz poziomy scrollbar
        set nowrap
        set cursorline         " zaznacz lini. z kursorem
        "set cursorcolumn       " zaznacz kolumn. z kursorem
endif
endif
" automatyczne rozpoznawanie typu pliku, ladowanie specyficznego, dla danego typu, pluginu (ftplugin.vim, indent.vim):
filetype plugin indent on


""""""""""""""""""" AUTO COMMANDS: """"""""""""""""""""""""""""""""""{{{
if has("autocmd")
        autocmd BufEnter * :lcd %:p:h  " cd na katalog, w któ znajduje si. aktualny bufor
        " zaczynaj od ostatniej znanej pozycji kursora:
        autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g`\"" | endif
        " autouzupe.nianie z plikóyntax:
        autocmd FileType * execute "setlocal complete+="."k$VIMRUNTIME/syntax/".&ft.".vim"
        autocmd FileType text setlocal textwidth=78    " w plikach tekstowych zawijaj tekst po 78. znakach
        autocmd BufNewFile,Bufread *.php,*.php3,*.php4,*.php5 set keywordprg="help"
        "autocmd BufNewFile * startinsert       " rozpoczyna w trybie INSERT
        " zapami.tuj zak.adki, itp:
        "autocmd BufWinLeave *.* mkview
        "autocmd BufWinEnter *.* silent loadview
        "autocmd BufReadPost */stl_doc/*.html  :silent execute ":!elinks ".expand("%:p") | bdelete " tip 931
        autocmd BufNewFile,BufRead muttng-*-\w\+,muttng\w\{6\},ae\d setfiletype mail   " MuttNG
        "autocmd BufRead *.py set foldmethod=indent     " UWAGA: FileType pomija modeline, dlatego detekcja po rozszerzeniu
else
        set mouse=a    " myszka w konsoli
endif
"}}}

""""""""""""""""""" KLAWISZOLOGIA: """"""""""""""""""""""""""""""""""{{{
map             gb                         :bnext<CR>
map             gB                         :bprevious<CR>
map             <C-B>                              :!php -l %<CR>            " sprawdzanie sk.adni PHP
nnoremap        <silent><F8>                   :Tlist<CR>              " Tag List
map             <leader><leader>           [{V%zf                   " \\ wewnatrz bloku {} tworzy fold i go zamyka
inoremap        <Tab>                          <C-R>=InsertTabWrapper("backward")<CR>
inoremap        <S-Tab>                                <C-R>=InsertTabWrapper("forward")<CR>
map             <Leader>b                  GoZ<ESC>:g/^$/.,/./-j<CR>Gdd                   " Collapse multiple contiguous empty lines into a single line
map             <Leader>n                  GoZ<ESC>:g/^[ <Tab>]*$/.,/[^ <Tab>]/-j<CR>Gdd  " Collapse multiple contiguous blank lines into a single line
"map            <Leader>c                       :%s/[[:cntrl:]]/\r/g                            " Replace control characters with a new line separator
map             <Leader>d                  :%s/[<Char-128>-<Char-255>]//g                  " Delete extended characters (128-255)
map             <Leader>e                  :%s/\(.*[^ ][^ ]*\)  *$/\1/c                    " Remove trailing spaces at the end of a line
map             <Leader>f                  :%s/^  *\(.*\)/\1/c                             " Remove leading spaces at the beginning of a line
map             <Leader>g                  :%s/   */ /gc                                   " Collapse multiple contiguous spaces into a single space
map             <Leader>h                  :/<code>/+1,/<\/code>/-1s/&/\&amp;/gc           " Convert & to &amp; between CODE tags
map             <Leader>i                  :/<code>/+1,/<\/code>/-1s/</\&lt;/gc            " Convert < to &lt; between CODE tags
map             <Leader>j                  :/<code>/+1,/<\/code>/-1s/>/\&gt;/gc            " Convert > to &gt; between CODE tags
map             <silent><F12>                      <ESC>:ZoomWin<CR>
map             <C-W><C-F>                 <ESC>:FirstExplorerWindow<CR>
map             <C-W><C-B>                 <ESC>:BottomExplorerWindow<CR>
map             <C-W><C-T>                 <ESC>:WMToggle<CR>
" szukanie we wszystkich plikach:
nmap            <F3>                              :while !search( @/, "W") \| bnext \| endwhile<CR>
" szukaj zaznaczonego tekstu z '*' i '#' (a nie tylko wyrazu pod kursorem):
vnoremap        *                              y/<C-R>"<CR>
vnoremap        #                              y?<C-R>"<CR>
" wyszukiwanie TYLKO w zaznaczonym fragmencie:
vnoremap        /                              <ESC>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap        ?                              <ESC>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
" Make shift-insert work like in Xterm:
map             <S-Insert>                 <MiddleMouse>
map!            <S-Insert>                        <MiddleMouse>
" nie tra. zaznaczenia przy < i >
noremap         <                              <gv
noremap         >                              >gv
if version >= 700
        map            <silent><C-W>N                    <ESC>:tabnew<CR>
        imap           <silent><C-W>N                   <ESC>:tabnew<CR>
        "map            <silent><C-W><backspace><backspace>     <ESC>:e #<CR>
        "imap           <silent><C-W><backspace><backspace>     <ESC>:e #<CR>
        " sprawdzanie pisowni
        "map            <F7>                            :w<CR>:!ispell -x -d polish %<CR><CR>:e<CR><CR>
        map            <silent><F7>                      :setlocal spell!<CR>
        imap           <silent><F7>                     <ESC>:setlocal spell!<CR>
        " przemieszczanie zak.adek (tabókombinacj. ALT+, ALT+.
        nn <silent> <M-.> :if tabpagenr() == tabpagenr("$")\|tabm 0\|el\|exe "tabm ".tabpagenr()\|en<CR>
        nn <silent> <M-,> :if tabpagenr() == 1\|exe "tabm ".tabpagenr("$")\|el\|exe "tabm ".(tabpagenr()-2)\|en<CR>
	 	map <silent><Space> :noh<cr>
endif
"}}}

""""""""""""""""""" FUNKCJE: """"""""""""""""""""""""""""""""""""""""{{{
" tekst po zwini.ciu zak.adki:
function! MojFoldText()
        let linia = getline(v:foldstart)
        let linia = substitute(linia, '/\*\|\*/\|{{{\d\=\|//\|<!--\|-->', '', 'g')     "}}}
        return v:folddashes.' '.v:foldend.' (ZWINI.TO: '.(v:foldend-v:foldstart+1).') '.linia
endfunction

" Uzupe.nianie wyrazórzez <Tab> - TIP #102:
function! InsertTabWrapper(direction)
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
                return "\<tab>"
        elseif "backward" == a:direction
                return "\<c-p>"
        else
                return "\<c-n>"
        endif
endfunction

function! s:DiffWithSaved()
        let filetype=&ft
        diffthis
        " new | r # | normal 1Gdd - for horizontal split
        vnew | r # | normal 1Gdd
        diffthis
        execute "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! Diff call s:DiffWithSaved()

" TIP #1149: Returns either the contents of a fold or spelling suggestions.
if version >= 700
function! BalloonExpr()
        let foldStart = foldclosed(v:beval_lnum )
        let foldEnd   = foldclosedend(v:beval_lnum)
        let lines = []
        " If we're not in a fold...
        if foldStart < 0
                " If 'spell' is on and the word pointed to is incorrectly spelled, the tool tip will contain a few suggestions.
                let lines = spellsuggest( spellbadword( v:beval_text )[ 0 ], 5, 0 )
        else
                let numLines = foldEnd - foldStart + 1
                " Up to 31 lines get shown okay; beyond that, only 30 lines are shown with ellipsis in between to indicate too much.
                " The reason why 31 get shown okay is that 30 lines plus one of ellipsis is 31 anyway...
                if ( numLines > 31 )
                        let lines = getline( foldStart, foldStart + 14 )
                        let lines += [ '-- Snipped ' . ( numLines - 30 ) . ' lines --' ]
                        let lines += getline( foldEnd - 14, foldEnd )
                else
                        let lines = getline( foldStart, foldEnd )
                endif
        endif
        return join( lines, has( "balloon_multiline" ) ? "\n" : " " )
endfunction
endif
"}}}

""""""""""""""""""" PLUGINY: """"""""""""""""""""""""""""""""""""""""{{{
" TOhtml:
        let html_use_css=1     " domyslnie uzywa CSS zamiast <font>
        let use_xhtml=1                " domyslnie tworzy XHTML zamiast HTML
" WinManager:
        let g:miniBufExplMapWindowNavVim = 1
        let g:miniBufExplMapWindowNavArrows = 1
        let g:miniBufExplMapCTabSwitchBuffs = 1
        let g:persistentBehaviour = 1 " nie zamykaj VIMa jezeli zostanie tylko okno exploratora
" TimeStamp:
        let g:timestamp_modelines=20 " przeszukuj pierwsze 20 linii
        let g:timestamp_regexp = '\v\C%(\s+MODYFIKACJA:\s+)@<=.*$'
        let g:timestamp_rep = '%a %d-%m-%Y %R'
" BuffExplorer:
        let g:bufExplorerSortBy='number'
        let g:bufExplorerSplitType='v'
        let g:bufexplorersplitvertsize = 100
        let g:bufExplorerOpenMode=1          " Open using current window
        let g:bufExplorerSplitOutPathName=1
        let g:bufExplorerShowDirectories=1
" Enanced Commentify:
        let g:EnhCommentifyTraditionalMode = "No"
"}}}

set fdm=marker
set ts=4
set expandtab
set shiftwidth=4
set nosmartindent

" wczytaj ustawienia specyficzne dla danego komputera
if filereadable($HOME."/.vim/vimrc.local")
        source $HOME/.vim/vimrc.local
endif

