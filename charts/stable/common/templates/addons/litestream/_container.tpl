{{/*
The litestream sidecar container to be inserted.
*/}}
{{- define "common.addon.litestream.container" -}}
name: litestream
image: "{{ .Values.addons.litestream.image.repository }}:{{ .Values.addons.litestream.image.tag }}"
imagePullPolicy: {{ .Values.addons.litestream.image.pullPolicy }}
{{- with .Values.addons.litestream.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}

{{- if or .Values.addons.litestream.accessKeys.fromSecret .Values.addons.litestream.env }}
env:
{{- end }}

{{- with .Values.addons.litestream.env }}
{{- range $k, $v := . }}
  - name: {{ $k }}
    value: {{ $v | quote }}
{{- end }}
{{- end }}

{{- if .Values.addons.litestream.accessKeys.fromSecret }}
  - name: LITESTREAM_ACCESS_KEY_ID
    valueFrom:
      secretKeyRef:
        name: "{{ .Values.addons.litestream.accessKeys.secret.name }}"
        key: "{{ .Values.addons.litestream.accessKeys.secret.id }}"
  - name: LITESTREAM_SECRET_ACCESS_KEY
    valueFrom:
      secretKeyRef:
        name: "{{ .Values.addons.litestream.accessKeys.secret.name }}"
        key: "{{ .Values.addons.litestream.accessKeys.secret.key }}"
{{- end }}

args:
{{- range .Values.addons.litestream.args }}
- {{ . | quote }}
{{- end }}
{{- with .Values.addons.litestream.resources }}
resources:
  {{- toYaml . | nindent 2 }}
{{- end }}
volumeMounts:
  - name: {{ include "common.names.fullname" . }}-litestream
    mountPath: /etc/litestream.yml
    subPath: litestream.yml
{{- with .Values.addons.litestream.volumeMounts }}
  {{- toYaml . | nindent 2}}
{{- end }}
ports:
- name: metrics
  containerPort: {{ .Values.addons.litestream.metrics.port }}
{{- end -}}
