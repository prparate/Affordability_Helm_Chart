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
Set scylladb secret
*/}}
{{- define "SET_SCYLLADB_SECRET" -}}
{{- range $key, $val := .Values.secrets.scylladb_credentials }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: scylladb-secrets
      key: {{ $val }}
{{- end}}
{{- end }}

{{/*
Range scylladb configmap
*/}}
{{- define "SET_SCYLLADB_CONFIGMAP" -}}
{{- range $key, $val := .Values.configMaps.scylladb }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: scylladb-servers-configmap
      key: {{ $val }}
{{- end}}
{{- end }}

{{/*
Range env variables
*/}}
{{- define "SET_ENV_CONFIGS" -}}
{{ $appName := .Values.appName }}
{{- range $key, $val := .Values.configMaps.server }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: common-configmap
      key: {{ $val }}
{{- end}}
{{- range $key, $val := .Values.configMaps.env }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: {{ $appName }}-configmap
      key: {{ $key }}
{{- end}}
- name: PF_VERSION
  value: {{ .Values.image.tag }}
{{- end }}

{{/*
export for configmap 
*/}}
{{- define "EXPORT_ENV_CONFIGS" -}}
{{- range $key, $val := .Values.configMaps.env }}
{{ $key }}: {{ $val | quote }}
{{- end}}
{{- end }}

{{/*
Set external configmap from services-configmnap
*/}}
{{- define "SET_SERVICES_HOSTNAMES" -}}
{{- range $key, $val := .Values.configMaps.services }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: services-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set external configmap
*/}}
{{- define "SET_EXTERNAL_CONFIGMAP" -}}
{{- range $key, $val := .Values.configMaps.external_configmap }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: external-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set scylladb secret
*/}}
{{- define "SET_EXTERNAL_SECRET" -}}
{{- range $key, $val := .Values.secrets.external_secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: external-secrets
      key: {{ $val }}
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