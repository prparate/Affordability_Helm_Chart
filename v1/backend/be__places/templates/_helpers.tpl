{{/*
Set certificate secret name tls
*/}} 
{{- define "CERT_TLS_SECRET_NAME" -}}
{{ .Values.appName }}-svc-tls
{{- end -}}

{{/*
Set certificate tls files
*/}} 
{{- define "CERT_TLS_FILE_NAMES"  -}}
{{- range $key, $val := .Values.tls.files }}
- name: {{ $key }}
  value: {{ $val }}
{{- end }}
{{- end }}

{{/*
Create env variables based on secrets
*/}}
{{- define "LIST_ENV_VARIABLES"}}
{{ $sercretName :=  .Values.appName -}}
{{- range $key, $val := .Values.secrets.env.secretsEnv }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ printf "%s" $sercretName }}-secrets
      key: {{ $key }}
{{- end}}
- name: PF_VERSION
  value: {{ .Values.image.tag }}
{{- end }}

{{/*
Range and decode env variables 
*/}}
{{- define "CREATE_ENV_SECRETS" }}
{{- range $key, $val := .Values.secrets.env.secretsEnv }}
{{ $key }}: {{ $val | b64enc }}
{{- end}}
{{- end }}

{{/*
Set docker image
*/}}
{{- define "SET_DOCKER_IMAGE" -}}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag -}}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end }}
