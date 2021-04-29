{{- define "REST_INGRESS" -}}
{{- printf "cle-api-%s.internal.%s.premfina.com" .Values.pfenv .Values.pfvnet -}}
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
Set service hostnames
*/}}
{{- define "EXPORT_SERVICES_HOSTNAMES" -}}
{{- range $key, $val := .Values.configMaps.services }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: cle-services-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set service hostnames
*/}}
{{- define "EXPORT_ORACLE" -}}
{{- $cfgMap := printf "cle-oracle-%s-configmap" .Values.pfenv -}}
{{- range $key, $val := .Values.configMaps.cle_oracle_datasource }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: {{ $cfgMap }}
      # name: cle-oracle-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set service hostnames
*/}}
{{- define "EXPORT_ORACLE_SECRET" -}}
{{- $cfgMap := printf "cle-oracle-%s-secrets" .Values.pfenv -}}
{{- range $key, $val := .Values.configMaps.cle_oracle_secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ $cfgMap }}
      # name: cle-oracle-pf-dev-secrets
      key: {{ $key }}
{{- end}}
{{- end }}

{{/*
Set postgresdb secret
*/}}
{{- define "EXPORT_LOGGING" -}}
{{- $cfgMap := printf "cle-logging-api-%s-configmap" .Values.pfenv -}}
{{- range $key, $val := .Values.configMaps.cle_logging }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: {{ $cfgMap }}
      # name: cle-logging-api-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{- define "EXPORT_CFG" -}}
{{- $cfgMap := printf "cle-configuration-api-%s-configmap" .Values.pfenv -}}
{{- range $key, $val := .Values.configMaps.cle_configuration }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: {{ $cfgMap }}
      # name: cle-configuration-api-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}

{{- define "EXPORT_INT" -}}
{{- $cfgMap := printf "cle-integration-%s-configmap" .Values.pfenv -}}
{{- range $key, $val := .Values.configMaps.cle_integration }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: {{ $cfgMap }}
      # name: cle-integration-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}


{{- define "EXPORT_EMAIL" -}}
{{- $cfgMap := printf "cle-email-%s-configmap" .Values.pfenv -}}
{{- range $key, $val := .Values.configMaps.cle_email }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: {{ $cfgMap }}
      # name: cle-email-pf-dev-configmap
      key: {{ $key }}
{{- end}}
{{- end }}


{{- define "EXPORT_EMAIL_SECRET" -}}
{{- $cfgMap := printf "cle-email-%s-secrets" .Values.pfenv -}}
{{- range $key, $val := .Values.configMaps.cle_email_secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ $cfgMap }}
      # name: cle-email-pf-dev-secrets
      key: {{ $key }}
{{- end}}
{{- end }}

{{- define "EXPORT_EXT_SECRET" -}}
{{- $cfgMap := printf "cle-external-%s-secrets" .Values.pfenv -}}
{{- range $key, $val := .Values.configMaps.cle_external_secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ $cfgMap }}
      # name: cle-external-pf-dev-secrets
      key: {{ $key }}
{{- end}}
{{- end }}

{{- define "EXPORT_WEB_SECRET" -}}
{{- $cfgMap := printf "cle-websource-%s-secrets" .Values.pfenv -}}
{{- range $key, $val := .Values.configMaps.cle_websource_secrets }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: {{ $cfgMap }}
      # name: cle-websource-pf-dev-secrets
      key: {{ $key }}
{{- end}}
{{- end }}
