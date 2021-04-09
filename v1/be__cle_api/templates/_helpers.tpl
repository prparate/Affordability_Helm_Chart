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
Set service hostnames
*/}}
{{- define "EXPORT_SERVICES_HOSTNAMES" -}}
{{- range $key, $val := .Values.configMaps.services }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: cle-services-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set service hostnames
*/}}
{{- define "EXPORT_ORACLE" -}}
{{- range $key, $val := .Values.configMaps.cle_oracle_datasource }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: cle-oracle-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set service hostnames
*/}}
{{- define "EXPORT_ORACLE_SECRET" -}}
{{- range $key, $val := .Values.configMaps.cle_oracle_secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: cle-oracle-pf-dev-secrets
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set postgresdb secret
*/}}
{{- define "EXPORT_LOGGING" -}}
{{- range $key, $val := .Values.configMaps.cle_logging }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: cle-logging-api-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{- define "EXPORT_CFG" -}}
{{- range $key, $val := .Values.configMaps.cle_configuration }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: cle-configuration-api-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{- define "EXPORT_INT" -}}
{{- range $key, $val := .Values.configMaps.cle_integration }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: cle-integration-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}


{{- define "EXPORT_EMAIL" -}}
{{- range $key, $val := .Values.configMaps.cle_email }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: cle-email-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}


{{- define "EXPORT_EMAIL_SECRET" -}}
{{- range $key, $val := .Values.configMaps.cle_email_secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: cle-email-pf-dev-secrets
      key: {{ $key }}
{{- end}}
{{- end }}

{{- define "EXPORT_EXT_SECRET" -}}
{{- range $key, $val := .Values.configMaps.cle_external_secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: cle-external-pf-dev-secrets
      key: {{ $key }}
{{- end}}
{{- end }}

{{- define "EXPORT_WEB_SECRET" -}}
{{- range $key, $val := .Values.configMaps.cle_websource_secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: cle-websource-pf-dev-secrets
      key: {{ $key }}
{{- end}}
{{- end }}
