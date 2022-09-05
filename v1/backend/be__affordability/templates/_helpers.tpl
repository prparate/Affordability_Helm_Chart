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
Set service hostnames
*/}}
{{- define "EXPORT_SERVICES_HOSTNAMES" -}}
{{- range $key, $val := .Values.configMaps.services }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: services-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set env variables
*/}}
{{- define "SET_ENV_CONFIGS" -}}
{{- range $key, $val := .Values.configMaps.env }}
{{ $key }}: {{ $val | quote }}
{{- end}}
{{- end }}

{{/*
Set postgresdb secret
*/}}
{{- define "SET_POSTGRESDB_SECRET" -}}
{{- range $key, $val := .Values.secrets.database }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: postgresdb-secrets
      key: {{ $val }}
{{- end}}
{{- end }}

{{/*
Range env variables
*/}}
{{- define "EXPORT_ENV_CONFIGS" -}}
{{ $appName := .Values.appName }}
{{- range $key, $val := .Values.configMaps.database }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: postgres-configmap
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
Set docker image
*/}}
{{- define "SET_DOCKER_IMAGE" -}}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag -}}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end }}

{{/*
Set environment secrets
*/}}
{{- define "SET_ENV_SECRETS" -}}
{{- range $key, $val := .Values.secrets.env }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: be-affordability-secrets
      key: {{ $val }}
{{- end}}
{{- end }}

{{/*
Set service config
*/}}
{{- define "SET_SERVICE_CONFIG" -}}
{{- range $key, $val := .Values.configMaps.affordability_config }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: affordability-config
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set app insights config
*/}}
{{- define "SET_APP_INSIGHTS_CONFIG" -}}
{{- range $key, $val := .Values.configMaps.app_insights_config }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: app-insights-config
      key: {{ $key }}
{{- end}}
{{- end }}