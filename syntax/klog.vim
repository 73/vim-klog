" Quit when a syntax file was already loaded.
if exists("b:current_syntax")
  finish
endif

" everywhere
syntax match klogTag "#\S\+" contained

" Record Header
syntax region klogHeader start="^\d\{4}-\d\{2}-\d\{2}" end="$" contains=klogRecord,klogShould  nextgroup=klogRecordSummary,klogEntry skipnl
syntax region klogHeader start="^\d\{4}\/\d\{2}\/\d\{2}" end="$" contains=klogRecord,klogShould  nextgroup=klogRecordSummary,klogEntry skipnl
syntax match klogRecord "^\d\{4}-\d\{2}-\d\{2}\ze" contained nextgroup=klogShould skipwhite
syntax match klogRecord "^\d\{4}\/\d\{2}\/\d\{2}\ze" contained nextgroup=klogShould skipwhite
syntax match klogShould " (-*\(\d\+h\d\+m\|\d\+h\|\d\+m\)!)" contained
syntax region klogRecordSummary start="^\S" end="$" contained contains=klogTag nextgroup=klogEntry,klogRecordSummary skipnl

" Entries
syntax match klogEntrySummary "^\t\{2}\|\ \{4,8}.*" contained keepend contains=klogTag nextgroup=klogEntrySummary,klogEntry skipnl
syntax region klogEntry start="^\t\|\ \{2,4}-\(\d\+h\d\+m\|\d\+h\|\d\+m\)" end="$" contained keepend contains=klogTag,klogNegDuration nextgroup=klogEntrySummary,klogEntry skipnl
syntax match klogNegDuration "\(^\t\|\ \{2,4}\)\@<=-\(\d\+h\d\+m\|\d\+h\|\d\+m\)" contained
syntax region klogEntry start="^\t\|\ \{2,4}\(\d\+h\d\+m\|\d\+h\|\d\+m\)" end="$" contained keepend contains=klogTag,klogPosDuration nextgroup=klogEntrySummary,klogEntry skipnl
syntax match klogPosDuration "\(^\t\|\ \{2,4}\)\@<=\(\d\+h\d\+m\|\d\+h\|\d\+m\)" contained
syntax region klogEntry start="^\t\|\ \{2,4}<\=\d\{1,2}:\d\{2}\(\(am\)\|\(pm\)\)\=>\= - \(?\+\|\(\d\{1,2}:\d\{2}\(\(am\)\|\(pm\)\)\=>\=\)\)" end="$" contained keepend contains=klogTag,klogTimespan nextgroup=klogEntrySummary,klogEntry skipnl
syntax match klogTimespan "\(^\t\|\ \{2,4}\)\@<=<\=\d\{1,2}:\d\{2}\(\(am\)\|\(pm\)\)\=>\= - \(?\+\|\(\d\{1,2}:\d\{2}\(\(am\)\|\(pm\)\)\=>\=\)\)" contained

" Highlight
highlight default link klogTag Identifier
highlight default link klogRecord Underlined
highlight default link klogShould Statement
highlight default link klogRecordSummary Comment
highlight default link klogEntrySummary Comment
highlight default link klogEntry Comment
highlight default link klogPosDuration Type
highlight default link klogNegDuration String
highlight default link klogTimespan Keyword
" String

let b:current_syntax = 'klog'