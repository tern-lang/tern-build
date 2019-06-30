" Vim syntax file
" Language:	Tern
" Maintainer:	Niall Gallagher

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'tern'
elseif exists("b:current_syntax") && b:current_syntax == "tern"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("tern_fold")
  unlet tern_fold
endif


syn keyword ternCommentTodo      TODO FIXME XXX TBD contained
syn match   ternLineComment      "\/\/.*" contains=@Spell,ternCommentTodo
syn match   ternCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  ternComment	       start="/\*"  end="\*/" contains=@Spell,ternCommentTodo
syn match   ternSpecial	       "\\\d\d\d\|\\."
syn region  ternStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=ternSpecial,@htmlPreproc
syn region  ternStringS	       start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=ternSpecial,@htmlPreproc

syn match   ternSpecialCharacter "'\\.'"
syn match   ternNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  ternRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline

syn keyword ternConditional	if else switch match unless
syn keyword ternRepeat		while for do in loop until
syn keyword ternBranch		break continue
syn keyword ternOperator		new instanceof as
syn keyword ternStatement		return with yield await async
syn keyword ternBoolean		true false
syn keyword ternNull		null 
syn keyword ternLabel		case default
syn keyword ternException		try catch finally throw
syn keyword ternReserved		abstract class debug enum const let var extends import trait private public with static super synchronized 

if exists("tern_fold")
    syn match	ternFunction	"\<func\>"
    syn region	ternFunctionFold	start="\<func\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match ternSync	grouphere ternFunctionFold "\<func\>"
    syn sync match ternSync	grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword ternFunction	func
    syn match	ternBraces	   "[{}\[\]]"
    syn match	ternParens	   "[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "tern"
  syn sync ccomment ternComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_tern_syn_inits")
  if version < 508
    let did_tern_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink ternComment		Comment
  HiLink ternLineComment		Comment
  HiLink ternCommentTodo		Todo
  HiLink ternSpecial		Special
  HiLink ternStringS		String
  HiLink ternStringD		String
  HiLink ternCharacter		Character
  HiLink ternSpecialCharacter	ternSpecial
  HiLink ternNumber		ternValue
  HiLink ternConditional		Conditional
  HiLink ternRepeat		Repeat
  HiLink ternBranch		Conditional
  HiLink ternOperator		Operator
  HiLink ternType			Type
  HiLink ternStatement		Statement
  HiLink ternFunction		Function
  HiLink ternBraces		Function
  HiLink ternError		Error
  HiLink javaScrParenError		ternError
  HiLink ternNull			Keyword
  HiLink ternBoolean		Boolean
  HiLink ternRegexpString		String

  HiLink ternIdentifier		Identifier
  HiLink ternLabel		Label
  HiLink ternException		Exception
  HiLink ternMessage		Keyword
  HiLink ternGlobal		Keyword
  HiLink ternMember		Keyword
  HiLink ternDeprecated		Exception 
  HiLink ternReserved		Keyword
  HiLink ternDebug		Debug
  HiLink ternConstant		Label

  delcommand HiLink
endif

let b:current_syntax = "tern"
if main_syntax == 'tern'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
