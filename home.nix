{ config, pkgs, ... }:
{
  services.polybar = {
    enable = true;
    script = "polybar example &";
    extraConfig = ''
      [colors]
      ;background = ''${xrdb:color0:#222}
      background = #222
      background-alt = #444
      ;foreground = ''${xrdb:color7:#222}
      foreground = #dfdfdf
      foreground-alt = #555
      primary = #ffb52a
      secondary = #e60053
      alert = #bd2c40

      [bar/example]
      ;monitor = ''${env:MONITOR:HDMI-1}
      width = 100%
      height = 27
      ;offset-x = 1%
      ;offset-y = 1%
      radius = 6.0
      fixed-center = false

      background = ''${colors.background}
      foreground = ''${colors.foreground}

      line-size = 3
      line-color = #f00

      border-size = 4
      border-color = #00000000

      padding-left = 0
      padding-right = 2

      module-margin-left = 1
      module-margin-right = 2

      font-0 = fixed:pixelsize=10;1
      font-1 = unifont:fontformat=truetype:size=8:antialias=false;0
      font-2 = siji:pixelsize=10;1
      font-3 = "Iosevka Nerd Font:pixelsize=14;3"
      font-4 = "IPAex Gothic:pixelsize=12"

      modules-left = workspaces-xmonad
      modules-center = title-xmonad
      modules-right = filesystem xbacklight pulseaudio xkeyboard memory cpu wlan eth battery temperature date powermenu

      tray-position = right
      tray-padding = 2
      ;tray-background = #0063ff

      ;wm-restack = bspwm
      ;wm-restack = i3

      ;override-redirect = true

      ;scroll-up = bspwm-desknext
      ;scroll-down = bspwm-deskprev

      ;scroll-up = i3wm-wsnext
      ;scroll-down = i3wm-wsprev

      cursor-click = pointer
      cursor-scroll = ns-resize

      [module/xwindow]
      type = internal/xwindow
      label = %title:0:30:...%

      [module/xkeyboard]
      type = internal/xkeyboard
      blacklist-0 = num lock

      format-prefix = " "
      format-prefix-foreground = ''${colors.foreground-alt}
      format-prefix-underline = ''${colors.secondary}

      label-layout = %layout%
      label-layout-underline = ''${colors.secondary}

      label-indicator-padding = 2
      label-indicator-margin = 1
      label-indicator-background = ''${colors.secondary}
      label-indicator-underline = ''${colors.secondary}

      [module/filesystem]
      type = internal/fs
      interval = 25

      mount-0 = /

      label-mounted = %{F#0a81f5}%mountpoint%%{F-}: %percentage_used%%
      label-unmounted = %mountpoint% not mounted
      label-unmounted-foreground = ''${colors.foreground-alt}

      [module/bspwm]
      type = internal/bspwm

      label-focused = %index%
      label-focused-background = ''${colors.background-alt}
      label-focused-underline= ''${colors.primary}
      label-focused-padding = 2

      label-occupied = %index%
      label-occupied-padding = 2

      label-urgent = %index%!
      label-urgent-background = ''${colors.alert}
      label-urgent-padding = 2

      label-empty = %index%
      label-empty-foreground = ''${colors.foreground-alt}
      label-empty-padding = 2

      ; Separator in between workspaces
      ; label-separator = |

      [module/i3]
      type = internal/i3
      format = <label-state> <label-mode>
      index-sort = true
      wrapping-scroll = false

      ; Only show workspaces on the same output as the bar
      ;pin-workspaces = true

      label-mode-padding = 2
      label-mode-foreground = #000
      label-mode-background = ''${colors.primary}

      ; focused = Active workspace on focused monitor
      label-focused = %index%
      label-focused-background = ''${colors.background-alt}
      label-focused-underline= ''${colors.primary}
      label-focused-padding = 2

      ; unfocused = Inactive workspace on any monitor
      label-unfocused = %index%
      label-unfocused-padding = 2

      ; visible = Active workspace on unfocused monitor
      label-visible = %index%
      label-visible-background = ''${self.label-focused-background}
      label-visible-underline = ''${self.label-focused-underline}
      label-visible-padding = ''${self.label-focused-padding}

      ; urgent = Workspace with urgency hint set
      label-urgent = %index%
      label-urgent-background = ''${colors.alert}
      label-urgent-padding = 2

      ; Separator in between workspaces
      ; label-separator = |


      [module/mpd]
      type = internal/mpd
      format-online = <label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>

      icon-prev = 
      icon-stop = 
      icon-play = 
      icon-pause = 
      icon-next = 

      label-song-maxlen = 25
      label-song-ellipsis = true

      [module/xbacklight]
      type = internal/xbacklight

      format = <label> <bar>
      label = BL

      bar-width = 10
      bar-indicator = |
      bar-indicator-foreground = #fff
      bar-indicator-font = 2
      bar-fill = ─
      bar-fill-font = 2
      bar-fill-foreground = #9f78e1
      bar-empty = ─
      bar-empty-font = 2
      bar-empty-foreground = ''${colors.foreground-alt}

      [module/backlight-acpi]
      inherit = module/xbacklight
      type = internal/backlight
      card = intel_backlight

      [module/cpu]
      type = internal/cpu
      interval = 2
      format-prefix = " "
      format-prefix-foreground = ''${colors.foreground-alt}
      format-underline = #f90000
      label = %percentage:2%%

      [module/memory]
      type = internal/memory
      interval = 2
      format-prefix = " "
      format-prefix-foreground = ''${colors.foreground-alt}
      format-underline = #4bffdc
      label = %percentage_used%%

      [module/wlan]
      type = internal/network
      interface = wlp59s0
      interval = 3.0

      format-connected = <ramp-signal> <label-connected>
      format-connected-underline = #9f78e1
      label-connected = %essid%

      format-disconnected =
      ;format-disconnected = <label-disconnected>
      ;format-disconnected-underline = ''${self.format-connected-underline}
      ;label-disconnected = %ifname% disconnected
      ;label-disconnected-foreground = ''${colors.foreground-alt}

      ramp-signal-0 = 
      ramp-signal-1 = 
      ramp-signal-2 = 
      ramp-signal-3 = 
      ramp-signal-4 = 
      ramp-signal-foreground = ''${colors.foreground-alt}

      [module/eth]
      type = internal/network
      interface = enp0s31f6
      interval = 3.0

      format-connected-underline = #55aa55
      format-connected-prefix = " "
      format-connected-prefix-foreground = ''${colors.foreground-alt}
      label-connected = %local_ip%

      format-disconnected =
      ;format-disconnected = <label-disconnected>
      ;format-disconnected-underline = ''${self.format-connected-underline}
      ;label-disconnected = %ifname% disconnected
      ;label-disconnected-foreground = ''${colors.foreground-alt}

      [module/date]
      type = internal/date
      interval = 5

      date =" %Y-%m-%d"
      date-alt = 

      time = %H:%M
      time-alt = %H:%M:%S

      format-prefix = 
      format-prefix-foreground = ''${colors.foreground-alt}
      format-underline = #0a6cf5

      label = %date% %time%

      [module/pulseaudio]
      type = internal/pulseaudio

      format-volume = <label-volume> <bar-volume>
      label-volume = VOL %percentage%%
      label-volume-foreground = ''${root.foreground}

      label-muted = 🔇 muted
      label-muted-foreground = #666

      bar-volume-width = 10
      bar-volume-foreground-0 = #55aa55
      bar-volume-foreground-1 = #55aa55
      bar-volume-foreground-2 = #55aa55
      bar-volume-foreground-3 = #55aa55
      bar-volume-foreground-4 = #55aa55
      bar-volume-foreground-5 = #f5a70a
      bar-volume-foreground-6 = #ff5555
      bar-volume-gradient = false
      bar-volume-indicator = |
      bar-volume-indicator-font = 2
      bar-volume-fill = ─
      bar-volume-fill-font = 2
      bar-volume-empty = ─
      bar-volume-empty-font = 2
      bar-volume-empty-foreground = ''${colors.foreground-alt}

      [module/title-xmonad]
      type = custom/script
      exec = tail -F /tmp/.xmonad-title-log
      exec-if = [ -p /tmp/.xmonad-title-log ]
      tail = true

      [module/workspaces-xmonad]
      type = custom/script
      exec = tail -F /tmp/.xmonad-workspace-log
      exec-if = [ -p /tmp/.xmonad-workspace-log ]
      tail = true
      format-padding = 1
      ;format-margin = ''${margin.for-modules}

      [module/alsa]
      type = internal/alsa

      format-volume = <label-volume> <bar-volume>
      label-volume = VOL
      label-volume-foreground = ''${root.foreground}

      format-muted-prefix = " "
      format-muted-foreground = ''${colors.foreground-alt}
      label-muted = sound muted

      bar-volume-width = 10
      bar-volume-foreground-0 = #55aa55
      bar-volume-foreground-1 = #55aa55
      bar-volume-foreground-2 = #55aa55
      bar-volume-foreground-3 = #55aa55
      bar-volume-foreground-4 = #55aa55
      bar-volume-foreground-5 = #f5a70a
      bar-volume-foreground-6 = #ff5555
      bar-volume-gradient = false
      bar-volume-indicator = |
      bar-volume-indicator-font = 2
      bar-volume-fill = ─
      bar-volume-fill-font = 2
      bar-volume-empty = ─
      bar-volume-empty-font = 2
      bar-volume-empty-foreground = ''${colors.foreground-alt}

      [module/battery]
      type = internal/battery
      battery = BAT0
      adapter = AC
      full-at = 98

      format-charging = <animation-charging> <label-charging>
      format-charging-underline = #ffb52a

      format-discharging = <animation-discharging> <label-discharging>
      format-discharging-underline = ''${self.format-charging-underline}

      format-full-prefix = " "
      format-full-prefix-foreground = ''${colors.foreground-alt}
      format-full-underline = ''${self.format-charging-underline}

      ramp-capacity-0 = 
      ramp-capacity-1 = 
      ramp-capacity-2 = 
      ramp-capacity-foreground = ''${colors.foreground-alt}

      animation-charging-0 = 
      animation-charging-1 = 
      animation-charging-2 = 
      animation-charging-foreground = ''${colors.foreground-alt}
      animation-charging-framerate = 750

      animation-discharging-0 = 
      animation-discharging-1 = 
      animation-discharging-2 = 
      animation-discharging-foreground = ''${colors.foreground-alt}
      animation-discharging-framerate = 750

      [module/temperature]
      type = internal/temperature
      thermal-zone = 0
      warn-temperature = 60

      format = <ramp> <label>
      format-underline = #f50a4d
      format-warn = <ramp> <label-warn>
      format-warn-underline = ''${self.format-underline}

      label = %temperature-c%
      label-warn = %temperature-c%
      label-warn-foreground = ''${colors.secondary}

      ramp-0 = 
      ramp-1 = 
      ramp-2 = 
      ramp-foreground = ''${colors.foreground-alt}

      [module/powermenu]
      type = custom/menu

      expand-right = true

      format-spacing = 1

      label-open = 
      label-open-foreground = ''${colors.secondary}
      label-close =  cancel
      label-close-foreground = ''${colors.secondary}
      label-separator = |
      label-separator-foreground = ''${colors.foreground-alt}

      menu-0-0 = reboot
      menu-0-0-exec = menu-open-1
      menu-0-1 = power off
      menu-0-1-exec = menu-open-2

      menu-1-0 = cancel
      menu-1-0-exec = menu-open-0
      menu-1-1 = reboot
      menu-1-1-exec = sudo reboot

      menu-2-0 = power off
      menu-2-0-exec = sudo poweroff
      menu-2-1 = cancel
      menu-2-1-exec = menu-open-0

      [settings]
      screenchange-reload = true
      ;compositing-background = xor
      ;compositing-background = screen
      ;compositing-foreground = source
      ;compositing-border = over
      ;pseudo-transparency = false

      [global/wm]
      margin-top = 5
      margin-bottom = 5
    '';
  };
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      env.EDITOR = "nvim";
      window.padding = {
        x = 8;
        y = 4;
      };
      background_opacity = 0.7;
      font = {
        normal.family = "Hack";
        bold.family = "Hack";
        italic.family = "Hack";
        bold_italic.family = "Hack";
        size = 7.2;
      };
    };
  };
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.nerdtree
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-nix
      (pkgs.vimUtils.buildVimPluginFrom2Nix {
        name = "vim-commitita-2020-07-01";
        src = pkgs.fetchgit {
          url = "https://github.com/rhysd/committia.vim";
          rev = "2cded48477a5e308c77a0d289cc9b540669b701f";
          sha256 = "1g6ykdh7d16q6nvpvmxx4ss8w7cisx5r8qmbrrvhpwmbb3894pxp";
        };
        dependencies = [];
      })
    ];
    extraConfig = ''
      " language setting {{{
      augroup LanguageSetting
              autocmd!
              autocmd FileType satysfi,yaml,tml setl shiftwidth=2 tabstop=2 expandtab softtabstop=2
              autocmd FileType ocaml,cpp,c,kibanate setl shiftwidth=4 tabstop=4 noexpandtab softtabstop=2
      augroup END
      " }}}

      " undo persistence {{{
      augroup SaveEditPos
              autocmd!
              let s:undoDir = expand("~/.nvimundo")
              call system('mkdir ' . s:undoDir)
              let &undodir = s:undoDir
              set undofile
              " 編集位置保存設定
              autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
      augroup END
      " }}}

      " NERDTree {{{
      augroup NERDTreeSetting
              autocmd!
              if winwidth('%') > 120
                      autocmd StdinReadPre * let s:std_in = 1
                      if argc() == 0 || argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
                              " ディレクトリ又は指定なしではツリーにフォーカス
                              autocmd vimenter * NERDTreeToggle
                      else
                              " ファイル指定して開いた場合はバッファにフォーカス
                              autocmd vimenter * NERDTreeToggle | wincmd p
                      endif
              endif
              " NERDTree以外のバッファが閉じられたらNERDTreeも閉じる
              autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      augroup END

      " }}}

      " mkdir -p {{{
      augroup MakeFileRecurse
              autocmd!
              autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
                      function! s:auto_mkdir(dir, force)
                      if !isdirectory(a:dir) && (a:force ||
                      \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
                        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
                      endif
              endfunction
      augroup END
      " }}}

      " keybindings {{{
      augroup KeyBinding
              autocmd!
              nnoremap [del_word] diwi
              tnoremap [exit_term] <C-\><C-n>

              " 単語を削除しノーマルモードに復帰
              nmap r [del_word]

              nnoremap j gj
              nnoremap gj j
              nnoremap k gk
              nnoremap gk k

              " terminalからの脱出
              tmap <C-j> [exit_term]
      augroup END
      " }}}

      augroup Lazy
              autocmd!
              autocmd VimEnter * call LazySetting()
      augroup END


      autocmd FileType rust let b:coc_root_patterns = ['Cargo.toml']

      " mkdir -p {{{
      augroup MakeFileRecurse
              autocmd!
              autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
                      function! s:auto_mkdir(dir, force)
                      if !isdirectory(a:dir) && (a:force ||
                      \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
                        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
                      endif
              endfunction
      augroup END
      " }}}

      " keybindings {{{
      augroup KeyBinding
              autocmd!
              nnoremap [del_word] diwi
              tnoremap [exit_term] <C-\><C-n>

              " 単語を削除しノーマルモードに復帰
              nmap r [del_word]

              nnoremap j gj
              nnoremap gj j
              nnoremap k gk
              nnoremap gk k

              " terminalからの脱出
              tmap <C-j> [exit_term]
      augroup END
      " }}}

      " undo persistence {{{
      augroup SaveEditPos
              autocmd!
              let s:undoDir = expand("~/.nvimundo")
              call system('mkdir ' . s:undoDir)
              let &undodir = s:undoDir
              set undofile
              " 編集位置保存設定
              autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
      augroup END
      " }}}

      function LazySetting()

      " coc {{{
      augroup CoC
              " TextEdit might fail if hidden is not set.
              set hidden

              " Some servers have issues with backup files, see #649.
              set nobackup
              set nowritebackup

              " Give more space for displaying messages.
              set cmdheight=3

              " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
              " delays and poor user experience.
              set updatetime=300

              " Don't pass messages to |ins-completion-menu|.
              set shortmess+=c

              " Always show the signcolumn, otherwise it would shift the text each time
              " diagnostics appear/become resolved.
              if has("patch-8.1.1564")
                " Recently vim can merge signcolumn and number column into one
                set signcolumn=number
              else
                set signcolumn=yes
              endif

              " Use tab for trigger completion with characters ahead and navigate.
              " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
              " other plugin before putting this into your config.
              inoremap <silent><expr> <TAB>
                        \ pumvisible() ? "\<C-n>" :
                        \ <SID>check_back_space() ? "\<TAB>" :
                        \ coc#refresh()
              inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

              function! s:check_back_space() abort
                let col = col('.') - 1
                return !col || getline('.')[col - 1]  =~# '\s'
              endfunction

              " Use <c-space> to trigger completion.
              inoremap <silent><expr> <c-space> coc#refresh()

              " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
              " position. Coc only does snippet and additional edit on confirm.
              " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
              if exists('*complete_info')
                inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
              else
                inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
              endif

              " Use `[g` and `]g` to navigate diagnostics
              nmap <silent> [g <Plug>(coc-diagnostic-prev)
              nmap <silent> ]g <Plug>(coc-diagnostic-next)

              " GoTo code navigation.
              nmap <silent> gd <Plug>(coc-definition)
              nmap <silent> gy <Plug>(coc-type-definition)
              nmap <silent> gi <Plug>(coc-implementation)
              nmap <silent> gr <Plug>(coc-references)

              " Use K to show documentation in preview window.
              nnoremap <silent> K :call <SID>show_documentation()<CR>

              function! s:show_documentation()
                if (index(['vim','help'], &filetype) >= 0)
                      execute 'h '.expand('<cword>')
                else
                      call CocAction('doHover')
                endif
              endfunction

              " Highlight the symbol and its references when holding the cursor.
              autocmd CursorHold * silent call CocActionAsync('highlight')

              " Symbol renaming.
              nmap <leader>rn <Plug>(coc-rename)

              " Formatting selected code.
              xmap <leader>f  <Plug>(coc-format-selected)
              nmap <leader>f  <Plug>(coc-format-selected)
      augroup END

      augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
      augroup end

      " Applying codeAction to the selected region.
      " Example: `<leader>aap` for current paragraph
      xmap <leader>a  <Plug>(coc-codeaction-selected)
      nmap <leader>a  <Plug>(coc-codeaction-selected)

      " Remap keys for applying codeAction to the current buffer.
      nmap <leader>ac  <Plug>(coc-codeaction)
      " Apply AutoFix to problem on the current line.
      nmap <leader>qf  <Plug>(coc-fix-current)

      " Map function and class text objects
      " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
      xmap if <Plug>(coc-funcobj-i)
      omap if <Plug>(coc-funcobj-i)
      xmap af <Plug>(coc-funcobj-a)
      omap af <Plug>(coc-funcobj-a)
      xmap ic <Plug>(coc-classobj-i)
      omap ic <Plug>(coc-classobj-i)
      xmap ac <Plug>(coc-classobj-a)
      omap ac <Plug>(coc-classobj-a)

      " Use CTRL-S for selections ranges.
      " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
      nmap <silent> <C-s> <Plug>(coc-range-select)
      xmap <silent> <C-s> <Plug>(coc-range-select)

      " Add `:Format` command to format current buffer.
      command! -nargs=0 Format :call CocAction('format')

      " Add `:Fold` command to fold current buffer.
      command! -nargs=? Fold :call     CocAction('fold', <f-args>)

      " Add `:OR` command for organize imports of the current buffer.
      command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

      " Add (Neo)Vim's native statusline support.
      " NOTE: Please see `:h coc-status` for integrations with external plugins that
      " provide custom statusline: lightline.vim, vim-airline.
      set statusline^=%{coc#status()}%{get(b:,'coc_current_function',\'\')}

      " Mappings using CoCList:
      " Show all diagnostics.
      nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
      " Manage extensions.
      nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
      " Show commands.
      nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
      " Find symbol of current document.
      nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
      " Search workspace symbols.
      nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
      " Do default action for next item.
      nnoremap <silent> <space>j  :<C-u>CocNext<CR>
      " Do default action for previous item.
      nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
      " Resume latest coc list.
      nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
      " }}}

      " NERDTree {{{
      augroup NERDTreeSetting
              autocmd!
              if winwidth('%') > 120
                      autocmd StdinReadPre * let s:std_in = 1
                      if argc() == 0 || argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
                              " ディレクトリ又は指定なしではツリーにフォーカス
                              autocmd vimenter * NERDTreeToggle
                      else
                              " ファイル指定して開いた場合はバッファにフォーカス
                              autocmd vimenter * NERDTreeToggle | wincmd p
                      endif
                      " NERDTree以外のバッファが閉じられたらNERDTreeも閉じる
              endif
              autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      augroup END

      " }}}

      " quickhl {{{
      nmap <Space>m <Plug>(quickhl-manual-this)
      xmap <Space>m <Plug>(quickhl-manual-this)
      nmap <Space>M <Plug>(quickhl-manual-reset)
      xmap <Space>M <Plug>(quickhl-manual-reset)
      " }}}

      " vertical f {{{
      command -nargs=1 MyLineSearch let @m=<q-args> | call search('^\s*'. @m)
      command -nargs=1 MyLineBackSearch let @m=<q-args> | call search('^\s*'. @m, 'b')
      nnoremap <Space>f :MyLineSearch<Space>
      nnoremap <Space>F :MyLineBackSearch<Space>
      " }}}

      " command window {{{
      autocmd CmdwinEnter : g/^qa\?!\?$/d
      autocmd CmdwinEnter : g/^wq\?a\?!\?$/d
      " }}}

      set foldmethod=marker

      set hidden
      set number
      set relativenumber
      set noswapfile
      syntax on
      filetype plugin indent on
      "set tabstop=4
      "set shiftwidth=4
      "set noexpandtab
      set guicursor=
      set hls
      set list
      set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

      set clipboard+=unnamed

      " 以下カラースキーム設定
      set background=dark
      let g:artesanal_transp_bg = 0
      colorscheme koehler

      " 透過関連
      highlight Normal ctermbg=NONE guibg=NONE
      highlight NonText ctermbg=NONE guibg=NONE
      highlight SpecialKey ctermbg=NONE guibg=NONE
      highlight EndOfBuffer ctermbg=NONE guibg=NONE
      highlight LineNr ctermbg=NONE guibg=NONE
      highlight CocUnderline ctermbg=Red cterm=underline
      endfunction
    '';
  };
  programs.starship = { enable = true; };
  programs.fish = {
    plugins = [{
      name = "fish-ghq";
      src = pkgs.fetchFromGitHub {
        owner = "decors";
        repo = "fish-ghq";
        rev = "66722b711f0e59625c2b7fa8df1a3592313e7697";
        sha256 = "0rmcrdvxvs9i3fdbp7cnc7yjxdrg0i4qqzgfbanz26r0r19gvk77";
      };
    }];
    enable = true;
    shellAbbrs = {
      v = "nvim";
      gpo = "git push origin";
      lg = "lazygit";
    };
    shellAliases = {
      ll = "exa -l";
      lt = "exa -T";
      clipb = "xsel --clipboard --input";
    };
  };
  programs.bash = {
    enable = true;
    bashrcExtra = "exec fish";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "namachan";
  home.homeDirectory = "/home/namachan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
