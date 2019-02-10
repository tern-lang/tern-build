" Vim syntax file
" Language:	SnapScript
" Maintainer:	Niall Gallagher

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'snapscript'
elseif exists("b:current_syntax") && b:current_syntax == "snapscript"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("snap_fold")
  unlet snap_fold
endif


syn keyword snapCommentTodo      TODO FIXME XXX TBD contained
syn match   snapLineComment      "\/\/.*" contains=@Spell,snapCommentTodo
syn match   snapCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  snapComment	       start="/\*"  end="\*/" contains=@Spell,snapCommentTodo
syn match   snapSpecial	       "\\\d\d\d\|\\."
syn region  snapStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=snapSpecial,@htmlPreproc
syn region  snapStringS	       start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=snapSpecial,@htmlPreproc

syn match   snapSpecialCharacter "'\\.'"
syn match   snapNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  snapRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline

syn keyword snapConditional	if else switch match unless
syn keyword snapRepeat		while for do in loop until
syn keyword snapBranch		break continue
syn keyword snapOperator		new instanceof as
syn keyword snapStatement		return with yield await async
syn keyword snapBoolean		true false
syn keyword snapNull		null 
syn keyword snapLabel		case default
syn keyword snapException		try catch finally throw
syn keyword snapReserved		abstract class debug enum const let var extends import trait private public with static super synchronized 

if exists("snap_fold")
    syn match	snapFunction	"\<func\>"
    syn region	snapFunctionFold	start="\<func\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match snapSync	grouphere snapFunctionFold "\<func\>"
    syn sync match snapSync	grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword snapFunction	func
    syn match	snapBraces	   "[{}\[\]]"
    syn match	snapParens	   "[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "snapscript"
  syn sync ccomment snapComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_snapscript_syn_inits")
  if version < 508
    let did_snapscript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink snapComment		Comment
  HiLink snapLineComment		Comment
  HiLink snapCommentTodo		Todo
  HiLink snapSpecial		Special
  HiLink snapStringS		String
  HiLink snapStringD		String
  HiLink snapCharacter		Character
  HiLink snapSpecialCharacter	snapSpecial
  HiLink snapNumber		snapValue
  HiLink snapConditional		Conditional
  HiLink snapRepeat		Repeat
  HiLink snapBranch		Conditional
  HiLink snapOperator		Operator
  HiLink snapType			Type
  HiLink snapStatement		Statement
  HiLink snapFunction		Function
  HiLink snapBraces		Function
  HiLink snapError		Error
  HiLink javaScrParenError		snapError
  HiLink snapNull			Keyword
  HiLink snapBoolean		Boolean
  HiLink snapRegexpString		String

  HiLink snapIdentifier		Identifier
  HiLink snapLabel		Label
  HiLink snapException		Exception
  HiLink snapMessage		Keyword
  HiLink snapGlobal		Keyword
  HiLink snapMember		Keyword
  HiLink snapDeprecated		Exception 
  HiLink snapReserved		Keyword
  HiLink snapDebug		Debug
  HiLink snapConstant		Label

  delcommand HiLink
endif

let b:current_syntax = "snapscript"
if main_syntax == 'snapscript'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
