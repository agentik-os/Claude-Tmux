#!/bin/bash
# Chrome tunnels - Affiche le tunnel du projet OU le nombre total

CONFIG_FILE="$HOME/.tmux/tunnel-names.conf"
SESSION_NAME="$1"  # Passé par tmux: #S

# Mapping session -> port
declare -A SESSION_TO_PORT
SESSION_TO_PORT["Simono"]=9222
SESSION_TO_PORT["Dafnck"]=9223
SESSION_TO_PORT["Gluten"]=9224
SESSION_TO_PORT["Gluten-Libre"]=9224
SESSION_TO_PORT["Dentist"]=9225
SESSION_TO_PORT["DentistryGPT"]=9225
SESSION_TO_PORT["Agentik"]=9226
SESSION_TO_PORT["AgentikDev"]=9226
SESSION_TO_PORT["Kommu"]=9227
SESSION_TO_PORT["DevLens"]=9228
SESSION_TO_PORT["DevLensPro"]=9228

# Compter les tunnels actifs
count_tunnels() {
    local count=0
    for port in 9222 9223 9224 9225 9226 9227 9228; do
        ss -tln 2>/dev/null | grep -q ":$port " && ((count++))
    done
    echo $count
}

# Vérifier si un port spécifique est actif
is_port_active() {
    ss -tln 2>/dev/null | grep -q ":$1 "
}

# Load manual mappings pour les noms
declare -A PORT_NAMES
if [ -f "$CONFIG_FILE" ]; then
    while IFS='=' read -r port name; do
        [[ "$port" =~ ^[0-9]+$ ]] && PORT_NAMES[$port]="$name"
    done < <(grep -v '^#' "$CONFIG_FILE" | grep '=')
fi

# Si on a un nom de session qui correspond à un projet
if [ -n "$SESSION_NAME" ] && [ -n "${SESSION_TO_PORT[$SESSION_NAME]}" ]; then
    PROJECT_PORT="${SESSION_TO_PORT[$SESSION_NAME]}"
    PROJECT_NAME="${PORT_NAMES[$PROJECT_PORT]:-$SESSION_NAME}"

    if is_port_active "$PROJECT_PORT"; then
        echo "✓ $PROJECT_NAME"
    else
        echo "✗ $PROJECT_NAME"
    fi
else
    # Pas dans un projet -> afficher le nombre
    COUNT=$(count_tunnels)
    if [ "$COUNT" -gt 0 ]; then
        echo "$COUNT"
    else
        echo "0"
    fi
fi
