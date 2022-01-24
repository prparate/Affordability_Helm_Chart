
{{/*
Set certificate secret name tls
*/}} 
{{- define "CERT_TLS_SECRET_NAME" -}}
{{- $certSecretName := printf "%s-%s-svc-tls" .Values.appName .Values.pfEnv -}}
{{ $certSecretName }}
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
{{- $conigMapName := printf "%s-%s-configmap" .Values.appName .Values.pfEnv -}}
{{ $appName := .Values.appName }}
{{- range $key, $val := .Values.configMaps.env }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: {{ $conigMapName }}
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
Set Oracle Secret
*/}}
{{- define "SET_ORACLE_SECRET" -}}
{{- $secretsMap := printf "cle-oracle-%s-secrets" .Values.pfEnv -}}
{{- range $key, $val := .Values.secrets.oracle_credentials }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ $secretsMap }}
      key: {{ $val }}
{{- end }}
{{- end }}

{{/*
Export Oracle configmap
*/}}

{{- define "EXPORT_ORACLE_CONFIGMAP" -}}
{{- $cfgMap := printf "cle-oracle-%s-configmap" .Values.pfEnv -}}
{{- range $key, $val := .Values.configMaps.oracledb }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: {{ $cfgMap }}
      key: {{ $val }}
{{- end }}
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
