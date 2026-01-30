#!/bin/bash
# auto-follow.sh - Retour automatique au chat quand:
# 1. Nouveau output de Claude (réponse terminée)
# 2. Tu scrolles jusqu'en bas
# 3. Inactivité de 2 secondes en copy-mode
#
# Pour Wispr Flow: on sort du copy-mode pour que le texte collé aille dans le chat

PIDFILE="/tmp/tmux-auto-follow.pid"

# Éviter les instances multiples
if [[ -f "$PIDFILE" ]]; then
    OLD_PID=$(cat "$PIDFILE")
    if kill -0 "$OLD_PID" 2>/dev/null; then
        exit 0
    fi
fi

echo $$ > "$PIDFILE"
trap "rm -f $PIDFILE" EXIT

IDLE_COUNT=0

while true; do
    sleep 1

    # Vérifier si tmux tourne
    if ! tmux has-session 2>/dev/null; then
        sleep 5
        continue
    fi

    # Est-on en copy mode ?
    IN_COPY_MODE=$(tmux display-message -p '#{pane_in_mode}' 2>/dev/null)

    if [[ "$IN_COPY_MODE" != "1" ]]; then
        # Pas en copy mode = déjà focus sur le chat
        IDLE_COUNT=0
        continue
    fi

    # On est en copy-mode, vérifier si on est en bas (position du curseur)
    # scroll_position = 0 signifie qu'on est en bas
    SCROLL_POS=$(tmux display-message -p '#{scroll_position}' 2>/dev/null)

    if [[ "$SCROLL_POS" == "0" ]]; then
        # On est en bas → sortir du copy-mode immédiatement
        tmux send-keys -X cancel 2>/dev/null
        IDLE_COUNT=0
        continue
    fi

    # Incrémenter le compteur d'inactivité
    IDLE_COUNT=$((IDLE_COUNT + 1))

    # Après 2 secondes d'inactivité en copy-mode → sortir
    if [[ $IDLE_COUNT -ge 2 ]]; then
        tmux send-keys -X cancel 2>/dev/null
        IDLE_COUNT=0
    fi
done
