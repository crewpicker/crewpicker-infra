locals {
  selectorLabels = {
    app = var.name
    release = var.release
  }
}

resource "kubectl_manifest" "deployment" {
  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${var.name}-${var.release}
  labels:
${join("\n", [for k, v in local.selectorLabels : "    ${k}: ${v}"])}
spec:
  replicas: ${var.replicas}
  selector:
    matchLabels:
${join("\n", [for k, v in local.selectorLabels : "      ${k}: ${v}"])}
  template:
    metadata:
      labels:
${join("\n", [for k, v in local.selectorLabels : "        ${k}: ${v}"])}
    spec:
      containers:
      - name: ${var.name}
        image: ${var.image.repo}:${var.image.tag}
        ports:
        - containerPort: ${var.containerPort}
YAML
}

resource "kubectl_manifest" "service" {
  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: ${var.name}-${var.release}
  labels:
${join("\n", [for k, v in local.selectorLabels : "    ${k}: ${v}"])}
spec:
  selector:
${join("\n", [for k, v in local.selectorLabels : "    ${k}: ${v}"])}
  ports:
    - protocol: TCP
      port: 80
      targetPort: ${var.containerPort}
YAML
}

resource "kubectl_manifest" "ingress" {
  yaml_body = <<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${var.name}-${var.release}
  labels:
${join("\n", [for k, v in local.selectorLabels : "    ${k}: ${v}"])}
spec:
  rules:
  - host: "${var.hostname}"
    http:
      paths:
      - path: /
        pathType: Prefix
        h
        backend:
          service:
            name: ${var.name}-${var.release}
            port:
              number: 80
YAML
}
