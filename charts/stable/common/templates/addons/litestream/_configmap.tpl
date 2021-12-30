{{/*
The litestream config to be included.
*/}}
{{- define "common.addon.litestream.configmap" -}}
{{- if .Values.addons.litestream.enabled }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-litestream
  labels:
  {{- include "common.labels" . | nindent 4 }}
data:
  litestream.yaml: |
    dbs:
{{- with .Values.addons.litestream.dbs }}
  {{- toYaml . | nindent 6 }}
{{- end}}
{{- end }}
{{- end }}