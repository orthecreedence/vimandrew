" We're grateful for suggestions
"                  ( O O )
"   +===========oOO==(_)==OOo==============+
"   |                                      |
"   |     °v°   Sergio Luiz Araujo Silva   |
"   |    /(_)\  Linux User #423493         |
"   |     ^ ^   voyeg3r ?  gmail.com       |
"   +======================================+
" source: http://snipt.net/voyeg3r/convert-dos-file-to-unix-file
" Dos to Unix function

" try <esc> :dos2<tab><enter>
fun! Dos2unixFunction()
    let _s=@/

    let l = line(".")
    let c = col(".")

    try
        set ff=unix
        w!
        "%s/\%x0d$//e
    catch /E32:/
        echo "Sorry, the file is not saved"
    endtry
    let @/=_s

    call cursor(l, c)
endfun
com! Dos2Unix keepjumps call Dos2unixFunction()


