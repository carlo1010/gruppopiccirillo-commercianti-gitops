{{- define "tenant-platform.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "tenant-platform.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" (include "tenant-platform.name" .) .Values.tenant.slug | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "tenant-platform.namespace" -}}
{{- .Values.tenant.namespace -}}
{{- end -}}

{{- define "tenant-platform.labels" -}}
app.kubernetes.io/name: {{ include "tenant-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: tenant-platform
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
tenant.platform/tenant-id: {{ .Values.tenant.tenantId | quote }}
tenant.platform/tenant-slug: {{ .Values.tenant.slug | quote }}
tenant.platform/release-channel: {{ .Values.tenant.releaseChannel | quote }}
tenant.platform/theme-preset: {{ .Values.tenant.themePreset | quote }}
{{- range $key, $value := .Values.global.commonLabels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- range $key, $value := .Values.tenant.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end -}}

{{- define "tenant-platform.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tenant-platform.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
tenant.platform/tenant-slug: {{ .Values.tenant.slug | quote }}
{{- end -}}

{{- define "tenant-platform.componentSelectorLabels" -}}
{{ include "tenant-platform.selectorLabels" . }}
app.kubernetes.io/component: {{ .component | quote }}
{{- end -}}

{{- define "tenant-platform.serviceAccountName" -}}
{{- if .Values.global.serviceAccount.create -}}
{{- printf "%s-runtime" (include "tenant-platform.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- else -}}
default
{{- end -}}
{{- end -}}

{{- define "tenant-platform.frontendName" -}}
{{- printf "%s-frontend" (include "tenant-platform.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "tenant-platform.cmsName" -}}
{{- printf "%s-cms" (include "tenant-platform.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "tenant-platform.secretTargetName" -}}
{{- if .Values.externalSecrets.targetSecretName -}}
{{- .Values.externalSecrets.targetSecretName -}}
{{- else -}}
{{- printf "%s-app-secrets" (include "tenant-platform.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
