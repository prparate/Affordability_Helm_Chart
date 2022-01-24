
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
{{- define "EXPORT_SCYLLADB_CONFIGMAP" -}}
{{- range $key, $val := .Values.configMaps.scylladb }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: scylladb-servers-configmap
      key: {{ $val }}
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
Range env variables
*/}}
{{- define "EXPORT_ENV_CONFIGS" -}}
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
Set docker image
*/}}
{{- define "SET_DOCKER_IMAGE" -}}
{{- $registryName := .Values.image.registry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := .Values.image.tag -}}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end }}

{{/*
Set kafka servers
*/}}
{{- define "EXPORT_KAFKA_SERVERS_CONFIGMAP" -}}
{{- range $key, $val := .Values.configMaps.kafka_servers }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: kafka-servers-configmap
      key: {{ $val }}
{{- end}}
{{- end }}

{{/*
Set kafka topics
*/}}
{{- define "EXPORT_KAFKA_TOPICS" -}}
{{- range $key, $val := .Values.configMaps.kafka_topics }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: kafka-topics-configmap
      key: {{ $key }}
{{- end}}
{{- end }}
