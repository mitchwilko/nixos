let s:bg	 = g:atlas_colors["bg"][0]
let s:dark	 = g:atlas_colors["dark"][0]
let s:dim	 = g:atlas_colors["dim"][0]
let s:muted  = g:atlas_colors["muted"][0]
let s:normal = g:atlas_colors["normal"][0]
let s:bright = g:atlas_colors["bright"][0]
let s:white  = g:atlas_colors["white"][0]
let s:red	 = g:atlas_colors["red"][0]
let s:yellow = g:atlas_colors["yellow"][0]
let s:green  = g:atlas_colors["green"][0]
let s:amber  = g:atlas_colors["amber"][0]

if exists('g:lightline')
	let s:p = {'normal':{}, 'inactive':{}, 'insert':{}, 'replace':{}, 'visual':{}, 'tabline':{}, 'terminal':{}}

	" normal
	let s:p.normal.left   = [ [ s:bright, s:dim, 'bold'], [ s:bright, s:dark, 'bold' ] ]
	let s:p.normal.middle = [ [ s:normal, s:dark		   ] ]
	let s:p.normal.right  = [ [ s:bright, s:dim		   ], [ s:bright, s:dark		 ] ]
	let s:p.normal.error   = [ [ s:bg,	 s:red	  ] ]
	let s:p.normal.warning = [ [ s:dark, s:yellow ] ]

	" inactive
	let s:p.inactive.left	= [ [ s:normal, s:dark	], [ s:normal, s:dark  ] ]
	let s:p.inactive.middle = [ [ s:muted,	s:dark	] ]
	let s:p.inactive.right	= [ [ s:muted,	s:dark	], [ s:normal, s:dark  ] ]

	" insert
	let s:p.insert.left   = [ [ s:yellow,	s:dim,	  'bold' ], [ s:bright, s:dark, 'bold' ] ]
	let s:p.insert.middle = [ [ s:normal,	s:dark			] ]
	let s:p.insert.right  = [ [ s:yellow,	s:dim			 ], [ s:bright, s:dark		   ] ]

	" replace
	let s:p.replace.left   = [ [ s:muted,	s:dim,	'bold' ], [ s:bright, s:dark, 'bold' ] ]
	let s:p.replace.middle = [ [ s:normal,	s:dark		  ] ]
	let s:p.replace.right  = [ [ s:muted,	s:dim		   ], [ s:bright, s:dark		 ] ]

	" visual
	let s:p.visual.left   = [ [ s:green,	s:dim,	'bold' ], [ s:bright, s:dark, 'bold' ] ]
	let s:p.visual.middle = [ [ s:normal,	s:dark		  ] ]
	let s:p.visual.right  = [ [ s:green,	s:dim		   ], [ s:bright, s:dark		 ] ]

	" terminal
	let s:p.terminal.left	= [ [ s:red,	s:dim, 'bold' ], [ s:bright, s:dark, 'bold' ] ]
	let s:p.terminal.middle = [ [ s:normal, s:dark		 ] ]
	let s:p.terminal.right	= [ [ s:red,	s:dim		  ], [ s:bright, s:dark			] ]

	" tabline
	let s:p.tabline.left   = [ [ s:normal, s:dark	] ]
	let s:p.tabline.middle = [ [ s:bg,	   s:dim	 ] ]
	let s:p.tabline.tabsel = [ [ s:bg,	   s:normal ] ]
	let s:p.tabline.right  = [ [ s:bg,	   s:amber	  ] ]

	let g:lightline#colorscheme#mono#palette = lightline#colorscheme#fill(s:p)
endif
