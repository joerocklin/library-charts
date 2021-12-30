{{/*
Template to render litestream addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "common.addon.litestream" -}}
{{- if .Values.addons.litestream.enabled -}}
  {{/* Append the litestream container to the additionalContainers */}}
  {{- $container := include "common.addon.litestream.container" . | fromYaml -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-litestream" $container -}}
  {{- end -}}

  {{/* Include the configmap if not empty */}}
  {{- $configmap := include "common.addon.litestream.configmap" . -}}
  {{- if $configmap -}}
    {{- $configmap | nindent 0 -}}
  {{- end -}}
{{- end -}}
{{- end -}}
