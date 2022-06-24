{{/*
Set bitbucket runner secrets
*/}}
{{- define "SET_BITBUCKET_RUNNER_SECRET" -}}
{{- $appName := .Values.appName }}
{{- range $key, $val := .Values.secrets.bitbucket_runner_oauth }}
- name: {{ $key }}
  valueFrom:
    secretKeyRef:
      name: "runner-{{ $appName }}-secrets"
      key: {{ $val }}
{{- end }}
{{- end }}

{{/*
Range env variables
*/}}
{{- define "EXPORT_ENV_CONFIGS" -}}
{{ $appName := .Values.appName }}
{{- range $key, $val := .Values.configMaps.env }}
- name: {{ $key }}
  valueFrom:
    configMapKeyRef:
      name: "runner-{{ $appName }}-configmap"
      key: {{ $key }}
{{- end }}
- name: PF_VERSION
  value: {{ .Values.image.tag }}
{{- end }}

{{/*
Set env variables
*/}}
{{- define "SET_ENV_CONFIGS" -}}
{{- range $key, $val := .Values.configMaps.env }}
{{ $key }}: {{ printf "{%s}" $val }}
{{- end }}
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
Set docker in docker image
*/}}
{{- define "SET_DOCKER_IN_DOCKER" -}}
{{- $image := .Values.dind.image -}}
{{- $tag := .Values.dind.tag -}}
{{- printf "%s:%s" $image $tag -}}
{{- end }}