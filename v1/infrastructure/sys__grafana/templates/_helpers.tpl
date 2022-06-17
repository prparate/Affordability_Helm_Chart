{{/*
Set env variables
*/}}
{{- define "SET_ENV_CONFIGS" -}}
{{- range $key, $val := .Values.configMaps.env }}
- name: {{ $key }}
  value: {{ $val | quote }}
{{- end}}
{{- end }}
