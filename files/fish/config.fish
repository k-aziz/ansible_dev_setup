fish_add_path -g ~/.local/bin
fish_add_path -g /opt/homebrew/bin
fish_add_path -g /opt/homebrew/sbin
fish_add_path -g $PYENV_ROOT/bin
fish_add_path -g $CARGO_HOME/bin
fish_add_path -g $GOPATH/bin

set -gx EDITOR nvim

# Allow installing casks in non-admin systems
set -gx HOMEBREW_CASK_OPTS --appdir=~/Applications

if type -q bat
    abbr cat bat
end

if type -q eza
    function eza --wraps eza
        command eza --git --group-directories-first --hyperlink --icons=auto $argv
    end
    abbr ls eza
    abbr la eza -a
    abbr ll eza -l
    abbr lla eza -la
    abbr lt eza -T
end

if type -q pyenv
    pyenv init - | source
end

if type -q starship && type -q fish
    function starship_transient_prompt_func
        set -l _username (starship module username)
        set -l _colour_bg_username (set_color "0c121c")
        set -l rprompt (printf "%s%s " $_username $_colour_bg_username)
        echo $rprompt
    end

    function starship_transient_rprompt_func
        starship module time
    end
    starship init fish | source
    enable_transience

    # Starship newline conf disables newline at the beginning of a new shell
    # but also after every command. This adds a newline after each command.
    function newline --on-event fish_postexec
        echo
    end
end

abbr !! sudo vf

abbr dps docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"

abbr kbp kubectl get pods
abbr kbx kubectl exec -it
