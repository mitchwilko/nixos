if version > 580
	hi clear
	if exists('syntax_on')
		syntax reset
	endif
endif

let g:colors_name='mono'

let g:atlas_colors = {
  \ "bg"	  : ["#000000", 0],
  \ "dark"	  : ["#262626", 235],
  \ "dim"	  : ["#444444", 238],
  \ "muted"   : ["#808080", 244],
  \ "normal"  : ["#b2b2b2", 249],
  \ "bright"  : ["#e4e4e4", 254],
  \ "white"   : ["#ffffff", 15],
  \ "red"	  : ["#d70000", 160],
  \ "yellow"  : ["#ffdf00", 220],
  \ "green"   : ["#00af00", 34],
  \ "amber"	  : ["#d75f00", 166],
  \ "none"	  : ["NONE", "NONE"]
  \ }

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

function! s:hl(group, guifg, ...)
	let fg = g:atlas_colors[a:guifg]

	if a:0 >= 1
		let bg = g:atlas_colors[a:1]
	else
		let bg = g:atlas_colors["none"]
	endif

	if a:0 >= 2
		let style = a:2
	else
		let style = "NONE"
	endif

	let hi_str = [ "hi", a:group,
			\ 'guifg=' . fg[0], "ctermfg=" . fg[1],
			\ 'guibg=' . bg[0], "ctermbg=" . bg[1],
			\ 'gui=' . style, "cterm=" . style
			\ ]

	execute join(hi_str, ' ')
endfunction

" --- base groups ---
call s:hl("AtlasBg",		   "bg")
call s:hl("AtlasDark",		   "dark")
call s:hl("AtlasDim",		   "dim")
call s:hl("AtlasMuted",		   "muted")
call s:hl("AtlasNormal",	   "normal")
call s:hl("AtlasBright",	   "bright")
call s:hl("AtlasWhite",		   "white")
call s:hl("AtlasRed",		   "red")
call s:hl("AtlasRedItalic",    "red",	 "none", "italic")
call s:hl("AtlasYellow",	   "yellow")
call s:hl("AtlasYellowBold",   "yellow", "none", "bold")
call s:hl("AtlasGreen",		   "green")
call s:hl("AtlasBold",		   "none",	 "none", "bold")
call s:hl("AtlasItalic",	   "none",	 "none", "italic")
call s:hl("AtlasUnderline",    "none",	 "none", "underline")
call s:hl("AtlasBrightBold",   "bright", "none", "bold")
call s:hl("AtlasBrightUnder",  "bright", "none", "underline")
call s:hl("AtlasNormalUnder",  "normal", "none", "underline")

" --- UI ---
call s:hl("Normal",		  "normal",  "bg")
call s:hl("LineNr",		  "muted",	   "none")
call s:hl("CursorLine",   "none",	  "none",	"underline")
call s:hl("CursorLineNr", "bright",  "dark")
call s:hl("CursorColumn", "none",	 "dark")
call s:hl("ColorColumn",  "none",	 "dark")
call s:hl("SignColumn",   "muted",	 "bg")
call s:hl("VertSplit",	  "dark",	 "dark")
call s:hl("Folded",		  "muted",	 "dark")
call s:hl("FoldColumn",   "muted",	 "dark")
call s:hl("NonText",	  "dim",	 "none")
call s:hl("SpecialKey",   "dim",	 "none")
call s:hl("Visual",		  "none",	 "bg",	 "reverse")
call s:hl("VisualNOS",	  "none",	 "bg",	 "reverse")
call s:hl("Directory",	  "bright",  "none")
call s:hl("Title",		  "bright",  "none", "bold")
call s:hl("MatchParen",   "red",	 "none", "bold")
call s:hl("Search",		  "white",	 "none", "bold,underline")
call s:hl("IncSearch",	  "bg",		 "white")
call s:hl("WildMenu",	  "bg",		 "normal", "bold")
call s:hl("PMenu",		  "normal",  "dark")
call s:hl("PMenuSel",	  "bright",  "dim")
call s:hl("PmenuSbar",	  "normal",  "normal")
call s:hl("PmenuThumb",   "white",	 "white")
call s:hl("StatusLine",   "normal",  "dark", "bold")
call s:hl("StatusLineNC", "muted",	 "dark")
call s:hl("TabLine",	  "muted",	 "dark")
call s:hl("TabLineFill",  "none",	 "dark")
call s:hl("TabLineSel",   "bright",  "none", "bold")
call s:hl("Question",	  "normal",  "none")
call s:hl("WarningMsg",   "yellow",  "none")
call s:hl("ErrorMsg",	  "red",	 "dark")
call s:hl("Error",		  "none",	 "red")
call s:hl("ModeMsg",	  "bright",  "none")
call s:hl("MoreMsg",	  "bright",  "none")
call s:hl("MsgArea",	  "normal",  "none")
call s:hl("Cursor",		  "normal",  "none", "reverse")
call s:hl("iCursor",	  "bg",		 "red")
call s:hl("vCursor",	  "bg",		 "bright")

" --- diffs ---
call s:hl("DiffAdd",	"green",  "bg")
call s:hl("DiffChange", "yellow", "bg")
call s:hl("DiffDelete", "red",	  "bg")
call s:hl("DiffText",	"none",   "none", "reverse")

hi! link diffAdded	  DiffAdd
hi! link diffRemoved  DiffDelete
hi! link diffChanged  DiffChange
hi! link diffSubname  AtlasMuted

hi! link diffBDiffer  WarningMsg
hi! link diffCommon   WarningMsg
hi! link diffDiffer   WarningMsg
hi! link diffFile	  Directory
hi! link diffIdentical WarningMsg
hi! link diffIndexLine AtlasNormal
hi! link diffIsA	  WarningMsg
hi! link diffNoEOL	  WarningMsg
hi! link diffOnly	  WarningMsg

" --- spell ---
call s:hl("SpellBad",	"red",	  "none", "underline")
call s:hl("SpellLocal", "yellow", "none", "underline")
call s:hl("SpellCap",	"normal", "none", "underline")
call s:hl("SpellRare",	"muted",  "none", "underline")

" --- syntax ---
call s:hl("Comment",	 "muted",  "none")
call s:hl("Constant",	 "normal", "none")
call s:hl("String",		 "normal", "none")
call s:hl("Number",		 "normal", "none")
call s:hl("Boolean",	 "normal", "none")
call s:hl("Float",		 "normal", "none")
call s:hl("Identifier",  "normal", "none")
call s:hl("Function",	 "normal", "none")
call s:hl("Statement",	 "normal",	  "none")
call s:hl("Conditional", "normal",	  "none")
call s:hl("Operator",	 "normal", "none")
call s:hl("Exception",	 "normal",	  "none")
call s:hl("PreProc",	 "normal", "none")
call s:hl("Type",		 "normal",	  "none")
call s:hl("Special",	 "normal", "none")
call s:hl("Underlined",  "none",   "none", "underline")
call s:hl("Todo",		 "yellow", "none", "bold")
call s:hl("Keyword",	 "bright",	  "none")
call s:hl("Delimiter",	 "white",  "none")
call s:hl("SpecialComment", "amber", "none", "bold")

hi! link Boolean	   Constant
hi! link Character	   Constant
hi! link Conceal	   Ignore
hi! link Debug		   Special
hi! link Define		   PreProc
hi! link Exception	   Statement
hi! link Float		   Number
hi! link Include	   Statement
hi! link Label		   Identifier
hi! link Macro		   PreProc
hi! link Noise		   Delimiter
hi! link PreCondit	   PreProc
hi! link Repeat		   Statement
hi! link StorageClass  Statement
hi! link Structure	   Statement
hi! link Tag		   Special
hi! link Whitespace    Ignore

hi! link StatusLineTerm   StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabLineSel		  StatusLine
hi! link TabLine		  StatusLineNC
hi! link TabLineFill	  StatusLineNC
hi! link Terminal		  Normal
hi! link VisualNOS		  Visual
hi! link IncSearch		  Search

" --- git gutter ---
call s:hl("GitGutterAdd",		   "green",  "none")
call s:hl("GitGutterChange",	   "yellow", "none")
call s:hl("GitGutterDelete",	   "red",	 "none")
call s:hl("GitGutterChangeDelete", "red",	 "none")

hi! link SignifySignAdd				GitGutterAdd
hi! link SignifySignDelete			GitGutterDelete
hi! link SignifySignDeleteFirstLine SignifySignDelete
hi! link SignifySignChange			GitGutterChange
hi! link SignifySignChangeDelete	GitGutterChangeDelete

" --- fugitive ---
call s:hl("FugitiveblameHash",			   "normal", "none")
call s:hl("FugitiveblameUncommitted",	   "red",	 "none")
call s:hl("FugitiveblameTime",			   "yellow", "none")
call s:hl("FugitiveblameNotCommittedYet",  "muted",  "none")

" --- gitcommit ---
call s:hl("gitcommitBranch",		"bright", "none")
call s:hl("gitcommitDiscardedFile", "red",	  "none")
call s:hl("gitcommitSelectedFile",	"green",  "none")
call s:hl("gitcommitUntrackedFile", "yellow", "none")
call s:hl("gitcommitHeader",		"normal", "none")

hi! link gitcommitDiscardedType gitcommitDiscardedFile
hi! link gitcommitSelectedType	gitcommitSelectedFile
hi! link gitcommitOverflow		Error
hi! link gitcommitSummary		Title

" --- ALE ---
hi! link ALEVirtualTextError   ErrorMsg
hi! link ALEVirtualTextWarning WarningMsg

" --- Coc ---
hi! link CocErrorSign		 ErrorMsg
hi! link CocWarningSign		 WarningMsg
hi! link CocInfoSign		 AtlasBright
hi! link CocHintSign		 AtlasMuted
hi! link CocErrorFloat		 ErrorMsg
hi! link CocWarningFloat	 WarningMsg
hi! link CocInfoFloat		 AtlasBright
hi! link CocHintFloat		 AtlasMuted
hi! link CocDiagnosticsError   ErrorMsg
hi! link CocDiagnosticsWarning WarningMsg
hi! link CocDiagnosticsInfo    AtlasBright
hi! link CocDiagnosticsHint    AtlasMuted
hi! link CocSelectedText	   AtlasRed
hi! link CocCodeLens		   AtlasMuted

call s:hl("CocErrorHighlight", "none", "none", "undercurl,bold")
hi! link CocWarningHighlight CocErrorHighlight
hi! link CocInfoHighlight	 CocErrorHighlight
hi! link CocHintHighlight	 CocErrorHighlight

" --- CSS ---
call s:hl("cssBoxAttr", "normal", "none")
call s:hl("cssNoise",	"normal", "none")

hi! link cssAtRule			   Keyword
hi! link cssAtKeyword		   Keyword
hi! link cssMediaProp		   Identifier
hi! link cssBoxProp			   Identifier
hi! link cssFlexibleBoxProp    cssBoxProp
hi! link cssPositioningProp    cssBoxProp
hi! link cssBackgroundProp	   cssBoxProp
hi! link cssBorderProp		   cssBoxProp
hi! link cssIEUIProp		   cssBoxProp
hi! link cssFontDescriptorProp cssBoxProp
hi! link cssTextProp		   cssBoxProp
hi! link cssCustomProp		   AtlasNormal
hi! link cssUIProp			   cssBoxProp
hi! link cssTransitionProp	   cssBoxProp
hi! link cssCascadeProp		   cssBoxProp
hi! link cssColorProp		   cssBoxProp
hi! link cssListProp		   cssBoxProp
hi! link cssPageProp		   cssBoxProp
hi! link cssAttrComma		   AtlasNormal
hi! link cssBackgroundAttr	   cssBoxAttr
hi! link cssBorderAttr		   cssBoxAttr
hi! link cssBraces			   cssNoise
hi! link cssClassName		   Identifier
hi! link cssColor			   AtlasBright
hi! link cssCommonAttr		   cssBoxAttr
hi! link cssFlexibleBoxAttr    cssBoxAttr
hi! link cssFunction		   Normal
hi! link cssIdentifier		   Identifier
hi! link cssMediaType		   Normal
hi! link cssMultiColumnAttr    cssBoxAttr
hi! link cssPositioningAttr    cssBoxAttr
hi! link cssProp			   Type
hi! link cssPseudoClassId	   Identifier
hi! link cssSelectorOp		   Operator
hi! link cssTableAttr		   cssBoxAttr
hi! link cssTagName			   Statement
hi! link cssTextAttr		   cssBoxAttr
hi! link cssTransitionAttr	   cssBoxAttr
hi! link cssUIAttr			   cssBoxAttr
hi! link cssUnitDecorators	   Normal
hi! link cssBoxPropAttr		   cssBoxAttr

" --- HTML ---
hi! link htmlArg			Special
hi! link htmlLink			AtlasNormalUnder
hi! link htmlSpecialTagName htmlTagName
hi! link htmlTag			Identifier
call s:hl("htmlTagName", "green", "none")

" --- JavaScript ---
call s:hl("jsFuncBraces", "normal", "none")

hi! link javaScriptBraces	   Normal
hi! link javaScriptFunction    Keyword
hi! link javaScriptIdentifier  Keyword
hi! link jsBuiltins			   Function
hi! link jsClassDefinition	   Type
hi! link jsDestructuringBraces jsFuncBraces
hi! link jsDomErrNo			   Identifier
hi! link jsDomNodeConsts	   Identifier
hi! link jsDot				   Normal
hi! link jsExceptions		   Type
hi! link jsFuncArgCommas	   jsFuncBraces
hi! link jsFuncName			   Function
hi! link jsFuncParens		   Normal
hi! link jsFunction			   Statement
hi! link jsGlobalNodeObjects   Function
hi! link jsGlobalObjects	   Normal
hi! link jsIfElseBraces		   jsFuncBraces
hi! link jsNoise			   jsFuncBraces
hi! link jsObjectBraces		   jsFuncBraces
hi! link jsObjectKey		   Identifier
hi! link jsObjectProp		   Identifier
hi! link jsObjectSeparator	   jsFuncBraces
hi! link jsOperatorKeyword	   Statement
hi! link jsParensIfElse		   jsFuncBraces
hi! link jsParens			   jsFuncBraces
hi! link jsThis				   Statement
hi! link jsVariableDef		   Identifier
hi! link jsBooleanTrue		   AtlasBright
hi! link jsBooleanFalse		   AtlasBright
hi! link jsRepeat			   Keyword
hi! link jsArrowFunction	   AtlasBright
hi! link jsTernaryIfOperator   Normal
hi! link jsNull				   AtlasBright
hi! link jsObjectColon		   AtlasRed
hi! link jsTemplateBraces	   AtlasRed
hi! link jsImport			   AtlasBright
hi! link jsExport			   AtlasBright
hi! link jsExportDefault	   AtlasBright
hi! link jsFrom				   AtlasBright

" --- TypeScript ---
hi! link typescriptArrayMethod		   Function
hi! link typescriptArrowFunc		   Operator
hi! link typescriptAssign			   Operator
hi! link typescriptBinaryOp			   Operator
hi! link typescriptBOM				   Type
hi! link typescriptBOMWindowCons	   Type
hi! link typescriptBOMWindowMethod	   Function
hi! link typescriptBOMWindowProp	   Type
hi! link typescriptBraces			   Delimiter
hi! link typescriptCall				   Normal
hi! link typescriptClassHeritage	   Type
hi! link typescriptClassName		   Type
hi! link typescriptDOMDocMethod		   Function
hi! link typescriptDOMDocProp		   Identifier
hi! link typescriptDOMEventCons		   Type
hi! link typescriptDOMEventMethod	   Function
hi! link typescriptDOMEventProp		   Identifier
hi! link typescriptDOMEventTargetMethod Function
hi! link typescriptDOMNodeMethod	   Function
hi! link typescriptDOMStorageMethod    Identifier
hi! link typescriptEndColons		   Delimiter
hi! link typescriptExport			  Keyword
hi! link typescriptFuncName			  Function
hi! link typescriptFuncTypeArrow	  typescriptArrowFunc
hi! link typescriptGlobal			  Type
hi! link typescriptIdentifier		  Keyword
hi! link typescriptInterfaceName	  Type
hi! link typescriptMember			  Function
hi! link typescriptObjectLabel		  Identifier
hi! link typescriptOperator			  Keyword
hi! link typescriptParens			  Delimiter
hi! link typescriptPredefinedType	  Type
hi! link typescriptTypeAnnotation	  Delimiter
hi! link typescriptTypeReference	  Type
hi! link typescriptUserDefinedType	  Type
hi! link typescriptVariableDeclaration Identifier
hi! link typescriptVariable			  Keyword

" --- JSON ---
hi! link jsonBoolean	  AtlasBright
hi! link jsonKeywordMatch AtlasNormal
hi! link jsonString		  String
hi! link jsonKeyword	  jsonString
hi! link jsonQuote		  jsonString
hi! link jsonNumber		  Number
hi! link jsonNull		  AtlasBright
hi! link jsonBraces		  Delimiter
hi! link jsonEscape		  AtlasBright
hi! link jsonNoise		  AtlasRed

" --- Markdown ---
call s:hl("markdownH1",			   "bright", "none", "bold")
call s:hl("markdownHeadingDelimiter", "red", "none", "bold")

hi! link markdownH2				  markdownH1
hi! link markdownH3				  markdownH1
hi! link markdownH4				  markdownH1
hi! link markdownH5				  markdownH1
hi! link markdownCode			  AtlasNormal
hi! link markdownCodeDelimiter	  AtlasNormal
hi! link markdownInlineCode		  markdownCode
hi! link markdownListMarker		  AtlasYellow
hi! link markdownLinkText		  AtlasBrightUnder
hi! link markdownUrl			  AtlasRedItalic
hi! link markdownLinkUrl		  markdownUrl
hi! link markdownBold			  AtlasBold
hi! link markdownItalic			  AtlasItalic
hi! link markdownBlockquote		  AtlasMuted
hi! link markdownRule			  AtlasMuted
hi! link markdownHeadingRule	  markdownHeadingDelimiter
hi! link markdownUrlTitle		  AtlasNormal
hi! link markdownIdDeclaration	  AtlasMuted
hi! link markdownAutomaticLink	  AtlasBrightUnder
hi! link markdownError			  AtlasRed

" --- YAML ---
call s:hl("yamlKey",	  "bright", "none")
call s:hl("yamlConstant", "red",	"none")

hi! link yamlFlowString			 String
hi! link yamlFlowStringDelimiter AtlasNormal
hi! link yamlKeyValueDelimiter	 AtlasRed

" --- TOML ---
call s:hl("tomlKey",			"bright", "none")
call s:hl("tomlKeyValueArray",	"bright", "none")
call s:hl("tomlTable",			"red",	  "none")

" --- Python ---
hi! link pythonClass		AtlasYellow
hi! link pythonRepeat		Keyword
hi! link pythonBoolean		Boolean
hi! link pythonBuiltin		Function
hi! link pythonBuiltinType	Type
hi! link pythonClassVar		AtlasNormal
hi! link pythonOperator		Operator
hi! link pythonRun			AtlasMuted
hi! link pythonDecorator	AtlasBright

" --- Rust ---
hi! link rustAttribute		Normal
hi! link rustCommentLineDoc Comment
hi! link rustDerive			rustAttribute
hi! link rustDeriveTrait	rustAttribute
hi! link rustEnumVariant	AtlasBright
hi! link rustIdentifier		Function
hi! link rustLifetime		AtlasMuted
hi! link rustMacro			AtlasBright
hi! link rustModPath		Normal
hi! link rustModPathSep		Keyword
hi! link rustOperator		Keyword
hi! link rustQuestionMark	Normal
hi! link rustSelf			AtlasBright

" --- Shell ---
hi! link shAlias			Identifier
hi! link shCaseLabel		Type
hi! link shDerefPPS			Keyword
hi! link shDeref			AtlasBright
hi! link shDerefSimple		AtlasBright
hi! link shDoubleQuote		String
hi! link shEcho				AtlasBright
hi! link shFunctionKey		Keyword
hi! link shFunctionOne		Normal
hi! link shOperator			Normal
hi! link shOption			Normal
hi! link shParen			Normal
hi! link shQuote			Constant
hi! link shRange			Normal
hi! link shRedir			Keyword
hi! link shSetList			Normal
hi! link shSnglCase			Normal
hi! link shStatement		Keyword
hi! link shVariable			AtlasRed
hi! link shWrapLineOperator Normal

" --- Go ---
hi! link goBuiltins		Function
hi! link goField		Identifier
hi! link goFunction		Function
hi! link goFunctionCall Function
hi! link goLabel		Keyword
hi! link goType			Normal
hi! link goVarAssign	Identifier
hi! link goVarDefs		Identifier

" --- CSS (SCSS) ---
hi! link scssAttribute			cssNoise
hi! link scssInclude			Keyword
hi! link scssMixin				Keyword
hi! link scssMixinName			Function
hi! link scssMixinParams		cssNoise
hi! link scssSelectorName		cssClassName
hi! link scssVariableAssignment Operator
hi! link scssVariableValue		Operator

" --- Vim help ---
hi! link helpCommand		AtlasBright
hi! link helpExample		AtlasNormal
hi! link helpHeadline		Title
hi! link helpHyperTextEntry Comment
hi! link helpHyperTextJump	AtlasNormalUnder
hi! link helpSectionDelim	AtlasMuted
hi! link helpURL			AtlasNormalUnder
hi! link helpVim			Title
hi! link helpNote			AtlasYellow

" --- Vim script ---
hi! link vimAutoCmdSfxList	Type
hi! link vimAutoEventList	Identifier
hi! link vimCmdSep			Delimiter
hi! link vimCommand			Keyword
hi! link vimCommentTitle	SpecialComment
hi! link vimContinue		Delimiter
hi! link vimExecute			Function
hi! link vimFuncName		Function
hi! link vimFunction		Function
hi! link vimFuncVar			Normal
hi! link vimGroup			Identifier
hi! link vimHiBang			Keyword
hi! link vimHighlight		Operator
hi! link vimHiGroup			AtlasNormal
hi! link vimIsCommand		Normal
hi! link vimLet				Keyword
hi! link vimMapModKey		Type
hi! link vimNotation		Type
hi! link vimOper			Keyword
hi! link vimOperParen		Normal
hi! link vimOption			Identifier
hi! link vimParenSep		Delimiter
hi! link vimSep				Normal
hi! link vimUserFunc		Function
hi! link vimVar				Normal
hi! link vimUserAttrb		Identifier
hi! link vimUserCommand		Identifier
hi! link vimPatSepR			AtlasGreen
hi! link vimPatRegion		vimPatSepR
hi! link vimSynNotPatRange	vimPatSepR
hi! link vimSynKeyRegion	Keyword
hi! link vimSynType			Identifier
hi! link vimSyncMatch		vimSynType

" --- Jinja ---
hi! link jinjaBlockName  Type
hi! link jinjaFilter	 Function
hi! link jinjaNumber	 Number
hi! link jinjaOperator	 Operator
hi! link jinjaRawDelim	 PreProc
hi! link jinjaSpecial	 Keyword
hi! link jinjaString	 String
hi! link jinjaTagDelim	 Delimiter
hi! link jinjaVarDelim	 Delimiter

" --- XML ---
hi! link xmlNamespace		 AtlasYellow
hi! link xmlAttribPunct		 AtlasRed
hi! link xmlProcessingDelim  AtlasRed

" --- NERDTree ---
call s:hl("NERDTreeDir",	  "normal", "none")
call s:hl("NERDTreeDirSlash", "muted",	"none")
call s:hl("NERDTreeFile",	  "normal", "none")
call s:hl("NERDTreeExecFile", "yellow", "none")
call s:hl("NERDTreeCWD",	  "bright", "none", "bold")
call s:hl("NERDTreeUp",		  "muted",	"none")
call s:hl("NERDTreeOpenable", "red",	"none")
call s:hl("NERDTreeClosable", "green",	"none")
call s:hl("NERDTreeHelp",	  "muted",	"none")
call s:hl("NERDTreeHelpKey",  "normal", "none")
call s:hl("NERDTreeHelpTitle","bright", "none", "bold")

" --- vim-plug ---
call s:hl("plug2",		   "normal", "none")
call s:hl("plugH2",		   "bright", "none", "bold")
call s:hl("plugBracket",   "normal", "none")
call s:hl("plugNumber",    "bright", "none")
call s:hl("plugDash",	   "muted",  "none")
call s:hl("plugStar",	   "normal", "none")
call s:hl("plugMessage",   "normal", "none")
call s:hl("plugName",	   "bright", "none")
call s:hl("plugUpdate",    "yellow", "none")
call s:hl("plugEdge",	   "muted",  "none")
call s:hl("plugSha",	   "muted",  "none")
call s:hl("plugNotLoaded", "dim",	 "none")
