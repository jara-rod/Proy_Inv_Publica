<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entidades.Proyecto" %>
<%!
    private String textoSeguro(String valor) {
        if (valor == null) return "";
        return valor.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>
<%
    List<Proyecto> lista = (List<Proyecto>) request.getAttribute("proyectos");
    String mensaje = (String) request.getAttribute("mensaje");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Proyectos de Inversión Pública</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4">Proyectos de Inversión Pública</h2>

    <% if (mensaje != null) { %>
        <div class="alert alert-success"><%= textoSeguro(mensaje) %></div>
    <% } %>
    <% if (error != null) { %>
        <div class="alert alert-danger"><%= textoSeguro(error) %></div>
    <% } %>

    <div class="row">
        <div class="col-md-5">
            <h4>Registrar Proyecto</h4>
            <form action="<%= request.getContextPath() %>/ProyectoServlet" method="post">
                <div class="mb-3">
                    <label class="form-label">Nombre del proyecto</label>
                    <input type="text" name="nombre" class="form-control" minlength="4" maxlength="60" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Descripción técnica (opcional)</label>
                    <textarea name="descripcion" class="form-control" rows="3"></textarea>
                </div>
                <div class="mb-3">
                    <label class="form-label">Fecha de inicio</label>
                    <input type="date" name="fechaInicio" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Fecha de culminación</label>
                    <input type="date" name="fechaFin" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Asesor técnico (nombres y apellidos)</label>
                    <input type="text" name="asesor" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Presupuesto asignado (S/)</label>
                    <input type="number" name="presupuesto" class="form-control" step="0.01" min="0" required>
                </div>
                <button type="submit" class="btn btn-primary">Registrar</button>
                <a href="<%= request.getContextPath() %>/ProyectoServlet" class="btn btn-warning">Listar</a>
            </form>
        </div>

        <div class="col-md-7">
            <h4>Proyectos Disponibles</h4>
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-sm">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Inicio</th>
                            <th>Fin</th>
                            <th>Asesor</th>
                            <th>Presupuesto</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% if (lista != null && !lista.isEmpty()) {
                        for (Proyecto p : lista) { %>
                        <tr>
                            <td><%= p.getId() %></td>
                            <td><%= textoSeguro(p.getNombre()) %></td>
                            <td><%= textoSeguro(p.getDescripcion()) %></td>
                            <td><%= textoSeguro(p.getFechaInicio()) %></td>
                            <td><%= textoSeguro(p.getFechaFin()) %></td>
                            <td><%= textoSeguro(p.getAsesor()) %></td>
                            <td>S/ <%= textoSeguro(p.getPresupuesto()) %></td>
                        </tr>
                    <%  }
                       } else { %>
                        <tr><td colspan="7" class="text-center">No hay proyectos registrados.</td></tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
