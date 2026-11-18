package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import entidades.Proyecto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ProyectoServlet")
public class ProyectoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private List<Proyecto> listaProyectos = new ArrayList<Proyecto>();
    private int contadorId = 1;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        mostrarPagina(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String fechaInicio = request.getParameter("fechaInicio");
        String fechaFin = request.getParameter("fechaFin");
        String asesor = request.getParameter("asesor");
        String presupuesto = request.getParameter("presupuesto");

        nombre = nombre == null ? "" : nombre.trim();
        descripcion = descripcion == null ? "" : descripcion.trim();
        fechaInicio = fechaInicio == null ? "" : fechaInicio.trim();
        fechaFin = fechaFin == null ? "" : fechaFin.trim();
        asesor = asesor == null ? "" : asesor.trim();
        presupuesto = presupuesto == null ? "" : presupuesto.trim();

        String error = "";

        if (nombre.length() < 4 || nombre.length() > 60) {
            error = "El nombre debe tener entre 4 y 60 caracteres.";
        } else if (fechaInicio.isEmpty() || fechaFin.isEmpty()) {
            error = "Debe ingresar las dos fechas.";
        } else if (asesor.isEmpty()) {
            error = "Debe ingresar el nombre del asesor.";
        } else if (presupuesto.isEmpty()) {
            error = "Debe ingresar el presupuesto.";
        } else {
            try {
                Double.parseDouble(presupuesto);
            } catch (NumberFormatException e) {
                error = "El presupuesto debe ser numérico.";
            }
        }

        if (error.isEmpty()) {
            Proyecto proyecto = new Proyecto(contadorId, nombre, descripcion,
                    fechaInicio, fechaFin, asesor, presupuesto);
            listaProyectos.add(proyecto);
            contadorId++;
            request.setAttribute("mensaje", "Proyecto registrado correctamente.");
        } else {
            request.setAttribute("error", error);
        }

        mostrarPagina(request, response);
    }

    private void mostrarPagina(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("proyectos", listaProyectos);
        request.getRequestDispatcher("/proyecto.jsp").forward(request, response);
    }
}
