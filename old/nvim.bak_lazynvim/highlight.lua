-- to check the highlight value of text under cursor, run:
-- :Inspect
-- https://vi.stackexchange.com/questions/39781/how-to-get-the-highlight-group-of-the-word-under-the-cursor-in-neovim-with-trees

-- to regenerate this file, do:
-- :redir >> nvim/conf/highlight.lua
-- :highlights
-- (<space> to get through all pages)
-- :redir END
--https://stackoverflow.com/questions/16049965/vim-save-highlight-info-screen-to-file

--https://gist.github.com/meskarune/1db61ed782143c4dc0f35dbfc7f7a336
--*cterm-colors* (re-ordered to match colortest-256 System color output)
--NR-16   NR-8    COLOR NAME
--0       0       black
--8       0*      darkgray
--4       1       darkred
--12      1*      red
--2       2       darkgreen
--10      2*      green
--6       3       darkyellow
--14      3*      yellow
--1       4       darkblue
--9       4*      blue
--5       5       darkmagenta
--13      5*      magenta
--3       6       darkcyan
--11      6*      cyan
--7       7       lightgray
--15      7*      white

-- examples:
--vim.cmd [[highlight Scrollview ctermbg=cyan]]
--vim.cmd [[hi clear Comment]]

-- (from vim :help color)
--You can see all the groups currently active with this command: >
--    :so $VIMRUNTIME/syntax/hitest.vim
--This will open a new window containing all highlight group names, displayed
--in their own color.


vim.cmd [[ hi clear Cursor]]
vim.cmd [[ hi clear TermCursor]]
vim.cmd [[ hi TermCursor gui=NONE cterm=NONE ctermbg=white ]]
vim.cmd [[ hi Cursor gui=NONE cterm=NONE ctermbg=white ]]
--TermCursor     xxx cterm=reverse gui=reverse
--Cursor         xxx guifg=bg guibg=fg
--FloatTitle     xxx links to Title
--lCursor        xxx guifg=bg guibg=fg

-- TODO: Is there a way to make color column a thin vertical line?
--ColorColumn    xxx ctermbg=0 guibg=DarkRed

-- set colors for command mode tab completion.
vim.cmd [[ hi Pmenu ctermbg=cyan ctermfg=black ]]
vim.cmd [[ hi PmenuSel ctermbg=yellow ctermfg=black ]]

-- set matching paren to no highlight so it is not visually confusing.
vim.cmd [[ highlight MatchParen cterm=underline ctermfg=NONE ctermbg=NONE ]]

vim.cmd [[ hi Visual cterm=NONE ctermbg=cyan ctermfg=black ]]
vim.cmd [[ hi clear VisualNC ]]
vim.cmd [[ hi Search cterm=NONE ctermbg=yellow ctermfg=black ]]
-- TODO: how do i set highlight color for current char in search word?
--vim.cmd [[ hi IncSearch ctermbg=green ]]
--vim.cmd [[ hi CurSearch ctermbg=green ]]

--IncSearch      xxx cterm=reverse gui=reverse
--Search         xxx ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
--CurSearch      xxx links to Search

-- when using status line plugin, one space to right side of each pane
-- (under the single-line divider) has highlight Statusline.
vim.cmd [[ hi Statusline cterm=bold ctermfg=black ctermbg=lightgray ]]
vim.cmd [[ hi StatusLineNC cterm=bold ctermfg=black ctermbg=lightgray ]]

vim.cmd [[ hi StatusLineExtra cterm=bold ctermfg=black ctermbg=cyan ]]
vim.cmd [[ hi StatusLineExtraNC cterm=bold ctermfg=black ctermbg=lightgray ]]

-- for Identifier, some config other than this one is turning on bold.
-- so turn it off here.
vim.cmd [[ hi Identifier cterm=NONE ctermfg=blue ]]

vim.cmd [[ hi PreProc ctermfg=darkred ]]
vim.cmd [[ hi Comment ctermfg=lightgray ]]
vim.cmd [[ hi Type ctermfg=darkgreen ]]
vim.cmd [[ hi Typedef ctermfg=darkgreen ]]
vim.cmd [[ hi Todo ctermbg=blue ]]

vim.cmd [[ hi LineNr ctermfg=darkgray ]]
--vim.cmd [[ hi CursorLineNr cterm=underline ctermfg=blue ctermbg=lightgray ]]
--vim.cmd [[ hi CursorLine ctermbg=black ]]
vim.api.nvim_set_hl(0, 'CursorLineNr', {ctermfg='yellow', underline = false})
vim.api.nvim_set_hl(0, 'CursorLine', {ctermbg='black', underline = false})

-- NvimTree
-- update: these are not really needed if base highlights are clean?
--vim.cmd [[ hi link NvimTreeNormalFloat StatusLine ]]
--vim.cmd [[ hi link NvimTreeCursorColumn StatusLine ]]
--vim.cmd [[ hi link NvimTreeExecFile StatusLine ]]
--vim.cmd [[ hi link NvimTreeImageFile StatusLine ]]
--vim.cmd [[ hi link NvimTreeSpecialFile StatusLine ]]
--vim.cmd [[ hi link NvimTreeSymlink StatusLine ]]
--vim.cmd [[ hi link NvimTreeCutHL StatusLine ]]
--vim.cmd [[ hi link NvimTreeCopiedHL StatusLine ]]
--vim.cmd [[ hi link NvimTreeStatusLine Statusline ]]
--vim.cmd [[ hi link NvimTreeStatusLineNC StatusLineNC ]]
--vim.cmd [[ hi link NvimTreeWindowPicker StatusLine ]]
--
--vim.cmd [[ hi SpecialKey ctermfg=cyan guifg=Cyan ]]
--vim.cmd [[ hi Statement ctermfg=yellow  guifg=yellow ]]
--vim.cmd [[ hi Directory ctermfg=blue guifg=blue ]]

-- folke/which-key.nvim
--WhichKey	Function	the key
--WhichKeyGroup	Keyword	a group
--WhichKeySeparator	DiffAdd	the separator between the key and its label
--WhichKeyDesc	Identifier	the label of the key
--WhichKeyFloat	NormalFloat	Normal in the popup window
--WhichKeyBorder	FloatBorder	Normal in the popup window
--WhichKeyValue	Comment	used by plugins that provide values
--vim.cmd [[ hi Function ctermbg=blue ]]
--vim.cmd [[ hi Keyword ctermbg=blue ]]
--vim.cmd [[ hi DiffAdd ctermbg=blue ]]
--vim.cmd [[ hi Identifier ctermbg=blue ]]
vim.cmd [[ hi NormalFloat ctermbg=black ]]
--vim.cmd [[ hi FloatBorder ctermbg=lightgray ]]
--vim.cmd [[ hi Comment ctermbg=blue ]]





-- copied from:
-- https://github.com/folke/lazy.nvim/blob/24fa2a97085ca8a7220b5b078916f81e316036fd/doc/lazy.nvim.txt#L20

--LazyButton          CursorLine               
--LazyButtonActive    Visual                   
--LazyComment         Comment                  
--LazyCommit          _@variable.builtin_      commitref
--LazyCommitIssue     Number                   
--LazyCommitScope     Italic                   conventional commit scope
--LazyCommitType      Title                    conventional commit type
--LazyDimmed          Conceal                  property
--LazyDir             _@markup.link_           directory
--LazyH1              IncSearch                homebutton
--LazyH2              Bold                     titles
--LazyLocal           Constant                 
--LazyNoCond          DiagnosticWarn           unloaded icon for a plugin where
--LazyNormal          NormalFloat              
--LazyProgressDone    Constant                 progress bar done
--LazyProgressTodo    LineNr                   progress bar todo
--LazyProp            Conceal                  property
--LazyReasonCmd       Operator                 
--LazyReasonEvent     Constant                 
--LazyReasonFt        Character                
--LazyReasonImport    Identifier               
--LazyReasonKeys      Statement                
--LazyReasonPlugin    Special                  
--LazyReasonRequire   _@variable.parameter_    
--LazyReasonRuntime   _@macro_                 
--LazyReasonSource    Character                
--LazyReasonStart     _@variable.member_       
--LazySpecial         _@punctuation.special_   
--LazyTaskError       ErrorMsg                 taskerrors
--LazyTaskOutput      MsgArea                  task output
--LazyUrl             _@markup.link_           url
--LazyValue           _@string_                valueof a property

--vim.cmd[[ hi clear LazyButton          ]]
--vim.cmd[[ hi clear LazyButtonActive    ]]
--vim.cmd[[ hi clear LazyComment         ]]
--vim.cmd[[ hi clear LazyCommit          ]]
--vim.cmd[[ hi clear LazyCommitIssue     ]]
--vim.cmd[[ hi clear LazyCommitScope     ]]
--vim.cmd[[ hi clear LazyCommitType      ]]
--vim.cmd[[ hi clear LazyDimmed          ]]
--vim.cmd[[ hi clear LazyDir             ]]
--vim.cmd[[ hi clear LazyH1              ]]
--vim.cmd[[ hi clear LazyH2              ]]
--vim.cmd[[ hi clear LazyLocal           ]]
--vim.cmd[[ hi clear LazyNoCond          ]]
--vim.cmd[[ hi clear LazyNormal          ]]
--vim.cmd[[ hi clear LazyProgressDone    ]]
--vim.cmd[[ hi clear LazyProgressTodo    ]]
--vim.cmd[[ hi clear LazyProp            ]]
--vim.cmd[[ hi clear LazyReasonCmd       ]]
--vim.cmd[[ hi clear LazyReasonEvent     ]]
--vim.cmd[[ hi clear LazyReasonFt        ]]
--vim.cmd[[ hi clear LazyReasonImport    ]]
--vim.cmd[[ hi clear LazyReasonKeys      ]]
--vim.cmd[[ hi clear LazyReasonPlugin    ]]
--vim.cmd[[ hi clear LazyReasonRequire   ]]
--vim.cmd[[ hi clear LazyReasonRuntime   ]]
--vim.cmd[[ hi clear LazyReasonSource    ]]
--vim.cmd[[ hi clear LazyReasonStart     ]]
--vim.cmd[[ hi clear LazySpecial         ]]
--vim.cmd[[ hi clear LazyTaskError       ]]
--vim.cmd[[ hi clear LazyTaskOutput      ]]
--vim.cmd[[ hi clear LazyUrl             ]]
--vim.cmd[[ hi clear LazyValue           ]]



--SpecialKey     xxx ctermfg=14 guifg=Cyan
--EndOfBuffer    xxx links to NonText
--TermCursor     xxx cterm=reverse gui=reverse
--TermCursorNC   xxx cleared
--NonText        xxx ctermfg=12 gui=bold guifg=Blue
--Directory      xxx ctermfg=14 guifg=Cyan
--ErrorMsg       xxx ctermfg=15 ctermbg=1 guifg=White guibg=Red
--IncSearch      xxx cterm=reverse gui=reverse
--Search         xxx ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
--CurSearch      xxx links to Search
--MoreMsg        xxx ctermfg=121 gui=bold guifg=SeaGreen
--ModeMsg        xxx cterm=bold gui=bold
--LineNr         xxx ctermfg=11 guifg=Yellow
--LineNrAbove    xxx links to LineNr
--LineNrBelow    xxx links to LineNr
--CursorLineNr   xxx cterm=underline ctermfg=11 gui=bold guifg=Yellow
--CursorLineSign xxx links to SignColumn
--CursorLineFold xxx links to FoldColumn
--Question       xxx ctermfg=121 gui=bold guifg=Green
--StatusLine     xxx cterm=bold ctermfg=0 ctermbg=14 gui=bold,reverse
--StatusLineNC   xxx cterm=bold ctermfg=0 ctermbg=7 gui=reverse
--WinSeparator   xxx links to VertSplit
--VertSplit      xxx links to Normal
--Title          xxx ctermfg=225 gui=bold guifg=Magenta
--Visual         xxx ctermfg=0 ctermbg=14 guibg=DarkGrey
--VisualNC       xxx cleared
--WarningMsg     xxx ctermfg=224 guifg=Red
--WildMenu       xxx ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
--Folded         xxx ctermfg=14 ctermbg=242 guifg=Cyan guibg=DarkGrey
--FoldColumn     xxx ctermfg=14 ctermbg=242 guifg=Cyan guibg=Grey
--DiffAdd        xxx ctermbg=4 guibg=DarkBlue
--DiffChange     xxx ctermbg=5 guibg=DarkMagenta
--DiffDelete     xxx ctermfg=12 ctermbg=6 gui=bold guifg=Blue guibg=DarkCyan
--DiffText       xxx cterm=bold ctermbg=9 gui=bold guibg=Red
--SignColumn     xxx ctermfg=14 ctermbg=242 guifg=Cyan guibg=Grey
--Conceal        xxx ctermfg=7 ctermbg=242 guifg=LightGrey guibg=DarkGrey
--SpellBad       xxx ctermbg=9 gui=undercurl guisp=Red
--SpellCap       xxx ctermbg=12 gui=undercurl guisp=Blue
--SpellRare      xxx ctermbg=13 gui=undercurl guisp=Magenta
--SpellLocal     xxx ctermbg=14 gui=undercurl guisp=Cyan
--Pmenu          xxx ctermfg=0 ctermbg=14 guibg=Magenta
--PmenuSel       xxx ctermfg=0 ctermbg=11 guibg=DarkGrey
--PmenuKind      xxx links to Pmenu
--PmenuKindSel   xxx links to PmenuSel
--PmenuExtra     xxx links to Pmenu
--PmenuExtraSel  xxx links to PmenuSel
--PmenuSbar      xxx ctermbg=248 guibg=Grey
--PmenuThumb     xxx ctermbg=15 guibg=White
--TabLine        xxx cterm=underline ctermfg=15 ctermbg=242 gui=underline guibg=DarkGrey
--TabLineSel     xxx cterm=bold gui=bold
--TabLineFill    xxx cterm=reverse gui=reverse
--CursorColumn   xxx ctermbg=242 guibg=Grey40
--CursorLine     xxx cterm=underline guibg=Grey40
--ColorColumn    xxx ctermbg=0 guibg=DarkRed
--QuickFixLine   xxx links to Search
--Whitespace     xxx links to NonText
--NormalNC       xxx cleared
--MsgSeparator   xxx links to StatusLine
--NormalFloat    xxx links to Pmenu
--MsgArea        xxx cleared
--FloatBorder    xxx links to WinSeparator
--WinBar         xxx cterm=bold gui=bold
--WinBarNC       xxx links to WinBar
--Cursor         xxx guifg=bg guibg=fg
--FloatTitle     xxx links to Title
--lCursor        xxx guifg=bg guibg=fg
--Normal         xxx cleared
--Substitute     xxx links to Search
--FloatShadow    xxx guibg=Black blend=80
--FloatShadowThrough xxx guibg=Black blend=100
--RedrawDebugNormal xxx cterm=reverse gui=reverse
--RedrawDebugClear xxx ctermbg=11 guibg=Yellow
--RedrawDebugComposed xxx ctermbg=10 guibg=Green
--RedrawDebugRecompose xxx ctermbg=9 guibg=Red
--Error          xxx ctermfg=15 ctermbg=9 guifg=White guibg=Red
--Todo           xxx ctermfg=0 ctermbg=11 guifg=Blue guibg=Yellow
--String         xxx links to Constant
--Constant       xxx ctermfg=13 guifg=#ffa0a0
--Character      xxx links to Constant
--Number         xxx links to Constant
--Boolean        xxx links to Constant
--Float          xxx links to Number
--Function       xxx links to Identifier
--Identifier     xxx cterm=bold ctermfg=14 guifg=#40ffff
--Conditional    xxx links to Statement
--Statement      xxx ctermfg=11 gui=bold guifg=Yellow
--Repeat         xxx links to Statement
--Label          xxx links to Statement
--Operator       xxx links to Statement
--Keyword        xxx links to Statement
--Exception      xxx links to Statement
--Include        xxx links to PreProc
--PreProc        xxx ctermfg=81 guifg=#ff80ff
--Define         xxx links to PreProc
--Macro          xxx links to PreProc
--PreCondit      xxx links to PreProc
--StorageClass   xxx links to Type
--Type           xxx ctermfg=121 gui=bold guifg=#60ff60
--Structure      xxx links to Type
--Typedef        xxx links to Type
--Tag            xxx links to Special
--Special        xxx ctermfg=224 guifg=Orange
--SpecialChar    xxx links to Special
--Delimiter      xxx links to Special
--SpecialComment xxx links to Special
--Debug          xxx links to Special
--DiagnosticError xxx ctermfg=1 guifg=Red
--DiagnosticWarn xxx ctermfg=3 guifg=Orange
--DiagnosticInfo xxx ctermfg=4 guifg=LightBlue
--DiagnosticHint xxx ctermfg=7 guifg=LightGrey
--DiagnosticOk   xxx ctermfg=10 guifg=LightGreen
--DiagnosticUnderlineError xxx cterm=underline gui=underline guisp=Red
--DiagnosticUnderlineWarn xxx cterm=underline gui=underline guisp=Orange
--DiagnosticUnderlineInfo xxx cterm=underline gui=underline guisp=LightBlue
--DiagnosticUnderlineHint xxx cterm=underline gui=underline guisp=LightGrey
--DiagnosticUnderlineOk xxx cterm=underline gui=underline guisp=LightGreen
--DiagnosticVirtualTextError xxx links to DiagnosticError
--DiagnosticVirtualTextWarn xxx links to DiagnosticWarn
--DiagnosticVirtualTextInfo xxx links to DiagnosticInfo
--DiagnosticVirtualTextHint xxx links to DiagnosticHint
--DiagnosticVirtualTextOk xxx links to DiagnosticOk
--DiagnosticFloatingError xxx links to DiagnosticError
--DiagnosticFloatingWarn xxx links to DiagnosticWarn
--DiagnosticFloatingInfo xxx links to DiagnosticInfo
--DiagnosticFloatingHint xxx links to DiagnosticHint
--DiagnosticFloatingOk xxx links to DiagnosticOk
--DiagnosticSignError xxx links to DiagnosticError
--DiagnosticSignWarn xxx links to DiagnosticWarn
--DiagnosticSignInfo xxx links to DiagnosticInfo
--DiagnosticSignHint xxx links to DiagnosticHint
--DiagnosticSignOk xxx links to DiagnosticOk
--DiagnosticDeprecated xxx cterm=strikethrough gui=strikethrough guisp=Red
--DiagnosticUnnecessary xxx links to Comment
--Comment        xxx ctermfg=248
--@text          xxx cleared
--@text.literal  xxx links to Comment
--@text.reference xxx links to Identifier
--@text.title    xxx links to Title
--@text.uri      xxx links to Underlined
--Underlined     xxx cterm=underline ctermfg=81 gui=underline guifg=#80a0ff
--@text.underline xxx links to Underlined
--@text.todo     xxx links to Todo
--@comment       xxx links to Comment
--@punctuation   xxx links to Delimiter
--@constant      xxx links to Constant
--@constant.builtin xxx links to Special
--@constant.macro xxx links to Define
--@define        xxx links to Define
--@macro         xxx links to Macro
--@string        xxx links to String
--@string.escape xxx links to SpecialChar
--@string.special xxx links to SpecialChar
--@character     xxx links to Character
--@character.special xxx links to SpecialChar
--@number        xxx links to Number
--@boolean       xxx links to Boolean
--@float         xxx links to Float
--@function      xxx links to Function
--@function.builtin xxx links to Special
--@function.macro xxx links to Macro
--@parameter     xxx links to Identifier
--@method        xxx links to Function
--@field         xxx links to Identifier
--@property      xxx links to Identifier
--@constructor   xxx links to Special
--@conditional   xxx links to Conditional
--@repeat        xxx links to Repeat
--@label         xxx links to Label
--@operator      xxx links to Operator
--@keyword       xxx links to Keyword
--@exception     xxx links to Exception
--@variable      xxx links to Identifier
--@type          xxx links to Type
--@type.definition xxx links to Typedef
--@storageclass  xxx links to StorageClass
--@namespace     xxx links to Identifier
--@include       xxx links to Include
--@preproc       xxx links to PreProc
--@debug         xxx links to Debug
--@tag           xxx links to Tag
--@lsp           xxx cleared
--@lsp.type.class xxx links to Structure
--@lsp.type.comment xxx links to Comment
--@lsp.type.decorator xxx links to Function
--@lsp.type.enum xxx links to Structure
--@lsp.type.enumMember xxx links to Constant
--@lsp.type.function xxx links to Function
--@lsp.type.interface xxx links to Structure
--@lsp.type.macro xxx links to Macro
--@lsp.type.method xxx links to Function
--@lsp.type.namespace xxx links to Structure
--@lsp.type.parameter xxx links to Identifier
--@lsp.type.property xxx links to Identifier
--@lsp.type.struct xxx links to Structure
--@lsp.type.type xxx links to Type
--@lsp.type.typeParameter xxx links to Typedef
--@lsp.type.variable xxx links to Identifier
--MatchParen     xxx cterm=underline guibg=DarkCyan
--Ignore         xxx ctermfg=0 guifg=bg
--NvimInternalError xxx ctermfg=9 ctermbg=9 guifg=Red guibg=Red
--NvimAssignment xxx links to Operator
--NvimPlainAssignment xxx links to NvimAssignment
--NvimAugmentedAssignment xxx links to NvimAssignment
--NvimAssignmentWithAddition xxx links to NvimAugmentedAssignment
--NvimAssignmentWithSubtraction xxx links to NvimAugmentedAssignment
--NvimAssignmentWithConcatenation xxx links to NvimAugmentedAssignment
--NvimOperator   xxx links to Operator
--NvimUnaryOperator xxx links to NvimOperator
--NvimUnaryPlus  xxx links to NvimUnaryOperator
--NvimUnaryMinus xxx links to NvimUnaryOperator
--NvimNot        xxx links to NvimUnaryOperator
--NvimBinaryOperator xxx links to NvimOperator
--NvimComparison xxx links to NvimBinaryOperator
--NvimComparisonModifier xxx links to NvimComparison
--NvimBinaryPlus xxx links to NvimBinaryOperator
--NvimBinaryMinus xxx links to NvimBinaryOperator
--NvimConcat     xxx links to NvimBinaryOperator
--NvimConcatOrSubscript xxx links to NvimConcat
--NvimOr         xxx links to NvimBinaryOperator
--NvimAnd        xxx links to NvimBinaryOperator
--NvimMultiplication xxx links to NvimBinaryOperator
--NvimDivision   xxx links to NvimBinaryOperator
--NvimMod        xxx links to NvimBinaryOperator
--NvimTernary    xxx links to NvimOperator
--NvimTernaryColon xxx links to NvimTernary
--NvimParenthesis xxx links to Delimiter
--NvimLambda     xxx links to NvimParenthesis
--NvimNestingParenthesis xxx links to NvimParenthesis
--NvimCallingParenthesis xxx links to NvimParenthesis
--NvimSubscript  xxx links to NvimParenthesis
--NvimSubscriptBracket xxx links to NvimSubscript
--NvimSubscriptColon xxx links to NvimSubscript
--NvimCurly      xxx links to NvimSubscript
--NvimContainer  xxx links to NvimParenthesis
--NvimDict       xxx links to NvimContainer
--NvimList       xxx links to NvimContainer
--NvimIdentifier xxx links to Identifier
--NvimIdentifierScope xxx links to NvimIdentifier
--NvimIdentifierScopeDelimiter xxx links to NvimIdentifier
--NvimIdentifierName xxx links to NvimIdentifier
--NvimIdentifierKey xxx links to NvimIdentifier
--NvimColon      xxx links to Delimiter
--NvimComma      xxx links to Delimiter
--NvimArrow      xxx links to Delimiter
--NvimRegister   xxx links to SpecialChar
--NvimNumber     xxx links to Number
--NvimFloat      xxx links to NvimNumber
--NvimNumberPrefix xxx links to Type
--NvimOptionSigil xxx links to Type
--NvimOptionName xxx links to NvimIdentifier
--NvimOptionScope xxx links to NvimIdentifierScope
--NvimOptionScopeDelimiter xxx links to NvimIdentifierScopeDelimiter
--NvimEnvironmentSigil xxx links to NvimOptionSigil
--NvimEnvironmentName xxx links to NvimIdentifier
--NvimString     xxx links to String
--NvimStringBody xxx links to NvimString
--NvimStringQuote xxx links to NvimString
--NvimStringSpecial xxx links to SpecialChar
--NvimSingleQuote xxx links to NvimStringQuote
--NvimSingleQuotedBody xxx links to NvimStringBody
--NvimSingleQuotedQuote xxx links to NvimStringSpecial
--NvimDoubleQuote xxx links to NvimStringQuote
--NvimDoubleQuotedBody xxx links to NvimStringBody
--NvimDoubleQuotedEscape xxx links to NvimStringSpecial
--NvimFigureBrace xxx links to NvimInternalError
--NvimSingleQuotedUnknownEscape xxx links to NvimInternalError
--NvimSpacing    xxx links to Normal
--NvimInvalidSingleQuotedUnknownEscape xxx links to NvimInternalError
--NvimInvalid    xxx links to Error
--NvimInvalidAssignment xxx links to NvimInvalid
--NvimInvalidPlainAssignment xxx links to NvimInvalidAssignment
--NvimInvalidAugmentedAssignment xxx links to NvimInvalidAssignment
--NvimInvalidAssignmentWithAddition xxx links to NvimInvalidAugmentedAssignment
--NvimInvalidAssignmentWithSubtraction xxx links to NvimInvalidAugmentedAssignment
--NvimInvalidAssignmentWithConcatenation xxx links to NvimInvalidAugmentedAssignment
--NvimInvalidOperator xxx links to NvimInvalid
--NvimInvalidUnaryOperator xxx links to NvimInvalidOperator
--NvimInvalidUnaryPlus xxx links to NvimInvalidUnaryOperator
--NvimInvalidUnaryMinus xxx links to NvimInvalidUnaryOperator
--NvimInvalidNot xxx links to NvimInvalidUnaryOperator
--NvimInvalidBinaryOperator xxx links to NvimInvalidOperator
--NvimInvalidComparison xxx links to NvimInvalidBinaryOperator
--NvimInvalidComparisonModifier xxx links to NvimInvalidComparison
--NvimInvalidBinaryPlus xxx links to NvimInvalidBinaryOperator
--NvimInvalidBinaryMinus xxx links to NvimInvalidBinaryOperator
--NvimInvalidConcat xxx links to NvimInvalidBinaryOperator
--NvimInvalidConcatOrSubscript xxx links to NvimInvalidConcat
--NvimInvalidOr  xxx links to NvimInvalidBinaryOperator
--NvimInvalidAnd xxx links to NvimInvalidBinaryOperator
--NvimInvalidMultiplication xxx links to NvimInvalidBinaryOperator
--NvimInvalidDivision xxx links to NvimInvalidBinaryOperator
--NvimInvalidMod xxx links to NvimInvalidBinaryOperator
--NvimInvalidTernary xxx links to NvimInvalidOperator
--NvimInvalidTernaryColon xxx links to NvimInvalidTernary
--NvimInvalidDelimiter xxx links to NvimInvalid
--NvimInvalidParenthesis xxx links to NvimInvalidDelimiter
--NvimInvalidLambda xxx links to NvimInvalidParenthesis
--NvimInvalidNestingParenthesis xxx links to NvimInvalidParenthesis
--NvimInvalidCallingParenthesis xxx links to NvimInvalidParenthesis
--NvimInvalidSubscript xxx links to NvimInvalidParenthesis
--NvimInvalidSubscriptBracket xxx links to NvimInvalidSubscript
--NvimInvalidSubscriptColon xxx links to NvimInvalidSubscript
--NvimInvalidCurly xxx links to NvimInvalidSubscript
--NvimInvalidContainer xxx links to NvimInvalidParenthesis
--NvimInvalidDict xxx links to NvimInvalidContainer
--NvimInvalidList xxx links to NvimInvalidContainer
--NvimInvalidValue xxx links to NvimInvalid
--NvimInvalidIdentifier xxx links to NvimInvalidValue
--NvimInvalidIdentifierScope xxx links to NvimInvalidIdentifier
--NvimInvalidIdentifierScopeDelimiter xxx links to NvimInvalidIdentifier
--NvimInvalidIdentifierName xxx links to NvimInvalidIdentifier
--NvimInvalidIdentifierKey xxx links to NvimInvalidIdentifier
--NvimInvalidColon xxx links to NvimInvalidDelimiter
--NvimInvalidComma xxx links to NvimInvalidDelimiter
--NvimInvalidArrow xxx links to NvimInvalidDelimiter
--NvimInvalidRegister xxx links to NvimInvalidValue
--NvimInvalidNumber xxx links to NvimInvalidValue
--NvimInvalidFloat xxx links to NvimInvalidNumber
--NvimInvalidNumberPrefix xxx links to NvimInvalidNumber
--NvimInvalidOptionSigil xxx links to NvimInvalidIdentifier
--NvimInvalidOptionName xxx links to NvimInvalidIdentifier
--NvimInvalidOptionScope xxx links to NvimInvalidIdentifierScope
--NvimInvalidOptionScopeDelimiter xxx links to NvimInvalidIdentifierScopeDelimiter
--NvimInvalidEnvironmentSigil xxx links to NvimInvalidOptionSigil
--NvimInvalidEnvironmentName xxx links to NvimInvalidIdentifier
--NvimInvalidString xxx links to NvimInvalidValue
--NvimInvalidStringBody xxx links to NvimStringBody
--NvimInvalidStringQuote xxx links to NvimInvalidString
--NvimInvalidStringSpecial xxx links to NvimStringSpecial
--NvimInvalidSingleQuote xxx links to NvimInvalidStringQuote
--NvimInvalidSingleQuotedBody xxx links to NvimInvalidStringBody
--NvimInvalidSingleQuotedQuote xxx links to NvimInvalidStringSpecial
--NvimInvalidDoubleQuote xxx links to NvimInvalidStringQuote
--NvimInvalidDoubleQuotedBody xxx links to NvimInvalidStringBody
--NvimInvalidDoubleQuotedEscape xxx links to NvimInvalidStringSpecial
--NvimInvalidDoubleQuotedUnknownEscape xxx links to NvimInvalidValue
--NvimInvalidFigureBrace xxx links to NvimInvalidDelimiter
--NvimInvalidSpacing xxx links to ErrorMsg
--NvimDoubleQuotedUnknownEscape xxx links to NvimInvalidValue
--StatusLineExtra xxx cterm=bold ctermfg=0 ctermbg=14
--StatusLineExtraNC xxx cterm=bold ctermfg=0 ctermbg=7
--NvimTreeNormalFloat xxx links to StatusLine
--NvimTreeCursorColumn xxx links to StatusLine
--NvimTreeExecFile xxx links to StatusLine
--NvimTreeImageFile xxx links to StatusLine
--NvimTreeSpecialFile xxx links to StatusLine
--NvimTreeSymlink xxx links to StatusLine
--NvimTreeCutHL  xxx links to StatusLine
--NvimTreeCopiedHL xxx links to StatusLine
--NvimTreeStatusLine xxx links to StatusLine
--NvimTreeStatusLineNC xxx links to StatusLineNC
--NvimTreeWindowPicker xxx links to StatusLine
--NvimTreeFolderIcon xxx ctermfg=12 guifg=#8094b4
--NvimTreeOpenedHL xxx links to Special
--NvimTreeOpenedFile xxx cleared
--NvimTreeGitStagedIcon xxx links to Constant
--NvimTreeGitStaged xxx cleared
--NvimTreeGitDirtyIcon xxx links to Statement
--NvimTreeGitDirty xxx cleared
--NvimTreeGitRenamedIcon xxx links to PreProc
--NvimTreeGitRenamed xxx cleared
--NvimTreeGitDeletedIcon xxx links to Statement
--NvimTreeGitDeleted xxx cleared
--NvimTreeGitMergeIcon xxx links to Constant
--NvimTreeGitMerge xxx cleared
--NvimTreeGitNewIcon xxx links to PreProc
--NvimTreeGitNew xxx cleared
--NvimTreeGitIgnoredIcon xxx links to Comment
--NvimTreeGitIgnored xxx cleared
--NvimTreeGitFileMergeHL xxx links to NvimTreeGitMergeIcon
--NvimTreeFileMerge xxx cleared
--NvimTreeGitFileDeletedHL xxx links to NvimTreeGitDeletedIcon
--NvimTreeFileDeleted xxx cleared
--NvimTreeGitFileRenamedHL xxx links to NvimTreeGitRenamedIcon
--NvimTreeFileRenamed xxx cleared
--NvimTreeGitFileIgnoredHL xxx links to NvimTreeGitIgnoredIcon
--NvimTreeFileIgnored xxx cleared
--NvimTreeBookmarkIcon xxx links to NvimTreeFolderIcon
--NvimTreeBookmark xxx cleared
--NvimTreeDiagnosticErrorIcon xxx links to DiagnosticError
--NvimTreeLspDiagnosticsError xxx cleared
--NvimTreeDiagnosticWarnIcon xxx links to DiagnosticWarn
--NvimTreeLspDiagnosticsWarning xxx cleared
--NvimTreeDiagnosticInfoIcon xxx links to DiagnosticInfo
--NvimTreeLspDiagnosticsInformation xxx cleared
--NvimTreeDiagnosticHintIcon xxx links to DiagnosticHint
--NvimTreeLspDiagnosticsHint xxx cleared
--NvimTreeDiagnosticErrorFileHL xxx links to DiagnosticUnderlineError
--NvimTreeLspDiagnosticsErrorText xxx cleared
--NvimTreeDiagnosticWarnFileHL xxx links to DiagnosticUnderlineWarn
--NvimTreeLspDiagnosticsWarningText xxx cleared
--NvimTreeDiagnosticInfoFileHL xxx links to DiagnosticUnderlineInfo
--NvimTreeLspDiagnosticsInformationText xxx cleared
--NvimTreeDiagnosticHintFileHL xxx links to DiagnosticUnderlineHint
--NvimTreeLspDiagnosticsHintText xxx cleared
--NvimTreeDiagnosticErrorFolderHL xxx links to NvimTreeDiagnosticErrorFileHL
--NvimTreeLspDiagnosticsErrorFolderText xxx cleared
--NvimTreeDiagnosticWarnFolderHL xxx links to NvimTreeDiagnosticWarnFileHL
--NvimTreeLspDiagnosticsWarningFolderText xxx cleared
--NvimTreeModifiedIcon xxx links to Type
--NvimTreeModifiedFile xxx cleared
--NvimTreeDiagnosticHintFolderHL xxx links to NvimTreeDiagnosticHintFileHL
--NvimTreeLspDiagnosticsHintFolderText xxx cleared
--NvimTreeGitFileStagedHL xxx links to NvimTreeGitStagedIcon
--NvimTreeFileStaged xxx cleared
--NvimTreeGitFileDirtyHL xxx links to NvimTreeGitDirtyIcon
--NvimTreeFileDirty xxx cleared
--NvimTreeGitFileNewHL xxx links to NvimTreeGitNewIcon
--NvimTreeFileNew xxx cleared
--NvimTreeGitFolderDeletedHL xxx links to NvimTreeGitFileDeletedHL
--NvimTreeFolderDeleted xxx cleared
--NvimTreeGitFolderDirtyHL xxx links to NvimTreeGitFileDirtyHL
--NvimTreeFolderDirty xxx cleared
--NvimTreeGitFolderIgnoredHL xxx links to NvimTreeGitFileIgnoredHL
--NvimTreeFolderIgnored xxx cleared
--NvimTreeGitFolderMergeHL xxx links to NvimTreeGitFileMergeHL
--NvimTreeFolderMerge xxx cleared
--NvimTreeGitFolderNewHL xxx links to NvimTreeGitFileNewHL
--NvimTreeFolderNew xxx cleared
--NvimTreeGitFolderRenamedHL xxx links to NvimTreeGitFileRenamedHL
--NvimTreeFolderRenamed xxx cleared
--NvimTreeGitFolderStagedHL xxx links to NvimTreeGitFileStagedHL
--NvimTreeFolderStaged xxx cleared
--NvimTreeDiagnosticInfoFolderHL xxx links to NvimTreeDiagnosticInfoFileHL
--NvimTreeLspDiagnosticsInformationFolderText xxx cleared
--NvimTreeNormal xxx links to Normal
--NvimTreeNormalNC xxx links to NvimTreeNormal
--NvimTreeLineNr xxx links to LineNr
--NvimTreeWinSeparator xxx links to WinSeparator
--NvimTreeEndOfBuffer xxx links to EndOfBuffer
--NvimTreePopup  xxx links to Normal
--NvimTreeSignColumn xxx links to NvimTreeNormal
--NvimTreeCursorLine xxx links to CursorLine
--NvimTreeCursorLineNr xxx links to CursorLineNr
--NvimTreeRootFolder xxx links to Title
--NvimTreeFolderName xxx links to Directory
--NvimTreeEmptyFolderName xxx links to Directory
--NvimTreeOpenedFolderName xxx links to Directory
--NvimTreeSymlinkFolderName xxx links to Directory
--NvimTreeFileIcon xxx links to NvimTreeNormal
--NvimTreeSymlinkIcon xxx links to NvimTreeNormal
--NvimTreeOpenedFolderIcon xxx links to NvimTreeFolderIcon
--NvimTreeClosedFolderIcon xxx links to NvimTreeFolderIcon
--NvimTreeFolderArrowClosed xxx links to NvimTreeIndentMarker
--NvimTreeIndentMarker xxx links to NvimTreeFolderIcon
--NvimTreeFolderArrowOpen xxx links to NvimTreeIndentMarker
--NvimTreeLiveFilterPrefix xxx links to PreProc
--NvimTreeLiveFilterValue xxx links to ModeMsg
--NvimTreeBookmarkHL xxx links to SpellLocal
--NvimTreeModifiedFileHL xxx links to NvimTreeModifiedIcon
--NvimTreeModifiedFolderHL xxx links to NvimTreeModifiedFileHL
--Scrollview     xxx ctermbg=14
--ScrollViewConflictsTop xxx links to DiffAdd
--ScrollViewConflictsMiddle xxx links to DiffAdd
--ScrollViewConflictsBottom xxx links to DiffAdd
--ScrollViewCursor xxx links to WarningMsg
--ScrollViewDiagnosticsError xxx links to DiagnosticError
--ScrollViewDiagnosticsHint xxx links to DiagnosticHint
--ScrollViewDiagnosticsInfo xxx links to DiagnosticInfo
--ScrollViewDiagnosticsWarn xxx links to DiagnosticWarn
--ScrollViewFolds xxx links to Directory
--ScrollViewHover xxx links to CurSearch
--ScrollViewLocList xxx links to LineNr
--ScrollViewMarks xxx links to Identifier
--ScrollViewQuickFix xxx links to Constant
--ScrollViewRestricted xxx links to CurSearch
--ScrollViewSearch xxx links to NonText
--ScrollViewSpell xxx links to Statement
--ScrollViewTextWidth xxx links to Question
--LspInfoList    xxx cterm= gui=
--                   links to Function
--LspInfoTip     xxx cterm= gui=
--                   links to Comment
--LspInfoTitle   xxx cterm= gui=
--                   links to Title
--LspInfoFiletype xxx cterm= gui=
--                   links to Type
--LspInfoBorder  xxx cterm= gui=
--                   links to Label
--luaMetaMethod  xxx links to Function
--luaParenError  xxx links to Error
--luaParen       xxx cleared
--luaError       xxx links to Error
--luaFunction    xxx links to Function
--luaFunctionBlock xxx cleared
--luaCondElse    xxx links to Conditional
--luaCondEnd     xxx cleared
--luaCond        xxx links to Conditional
--luaCondElseif  xxx cleared
--luaCondStart   xxx cleared
--luaStatement   xxx links to Statement
--luaBlock       xxx cleared
--luaRepeat      xxx links to Repeat
--luaRepeatBlock xxx cleared
--luaWhile       xxx cleared
--luaFor         xxx links to Repeat
--luaLabel       xxx links to Label
--luaOperator    xxx links to Operator
--luaSymbolOperator xxx links to luaOperator
--luaTodo        xxx links to Todo
--luaComment     xxx links to Comment
--luaInnerComment xxx cleared
--luaCommentDelimiter xxx links to luaComment
--luaConstant    xxx links to Constant
--luaSpecial     xxx links to SpecialChar
--luaString2     xxx links to String
--luaStringDelimiter xxx links to luaString
--luaString      xxx links to String
--luaNumber      xxx links to Number
--luaTable       xxx links to Structure
--luaTableBlock  xxx cleared
--luaFunc        xxx links to Identifier
