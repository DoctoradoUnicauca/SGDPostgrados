package co.unicauca.proyectobase.controladores;

import co.unicauca.proyectobase.entidades.Archivo;
import co.unicauca.proyectobase.controladores.util.JsfUtil;
import co.unicauca.proyectobase.controladores.util.JsfUtil.PersistAction;
import co.unicauca.proyectobase.facades.ArchivoFacade;

import java.io.Serializable;
import java.util.List;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.inject.Named;
import javax.enterprise.context.SessionScoped;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.faces.convert.FacesConverter;

@Named("archivoController")
@SessionScoped
public class ArchivoController implements Serializable {

    @EJB
    private co.unicauca.proyectobase.facades.ArchivoFacade ejbFacade;
    private List<Archivo> items = null;
    private Archivo selected;

    public ArchivoController() {
    }

    public Archivo getSelected() {
        return selected;
    }

    public void setSelected(Archivo selected) {
        this.selected = selected;
    }

    protected void setEmbeddableKeys() {
        selected.getArchivoPK().setDocIdentificador(selected.getDocumentacion().getDocIdentificador());
    }

    protected void initializeEmbeddableKey() {
        selected.setArchivoPK(new co.unicauca.proyectobase.entidades.ArchivoPK());
    }

    private ArchivoFacade getFacade() {
        return ejbFacade;
    }

    public Archivo prepareCreate() {
        selected = new Archivo();
        initializeEmbeddableKey();
        return selected;
    }

    public void create() {
        persist(PersistAction.CREATE, ResourceBundle.getBundle("/Bundle").getString("ArchivoCreated"));
        if (!JsfUtil.isValidationFailed()) {
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public void update() {
        persist(PersistAction.UPDATE, ResourceBundle.getBundle("/Bundle").getString("ArchivoUpdated"));
    }

    public void destroy() {
        persist(PersistAction.DELETE, ResourceBundle.getBundle("/Bundle").getString("ArchivoDeleted"));
        if (!JsfUtil.isValidationFailed()) {
            selected = null; // Remove selection
            items = null;    // Invalidate list of items to trigger re-query.
        }
    }

    public List<Archivo> getItems() {
        if (items == null) {
            items = getFacade().findAll();
        }
        return items;
    }

    private void persist(PersistAction persistAction, String successMessage) {
        if (selected != null) {
            setEmbeddableKeys();
            try {
                if (persistAction != PersistAction.DELETE) {
                    getFacade().edit(selected);
                } else {
                    getFacade().remove(selected);
                }
                JsfUtil.addSuccessMessage(successMessage);
            } catch (EJBException ex) {
                String msg = "";
                Throwable cause = ex.getCause();
                if (cause != null) {
                    msg = cause.getLocalizedMessage();
                }
                if (msg.length() > 0) {
                    JsfUtil.addErrorMessage(msg);
                } else {
                    JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/Bundle").getString("PersistenceErrorOccured"));
                }
            } catch (Exception ex) {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, null, ex);
                JsfUtil.addErrorMessage(ex, ResourceBundle.getBundle("/Bundle").getString("PersistenceErrorOccured"));
            }
        }
    }

    public Archivo getArchivo(co.unicauca.proyectobase.entidades.ArchivoPK id) {
        return getFacade().find(id);
    }

    public List<Archivo> getItemsAvailableSelectMany() {
        return getFacade().findAll();
    }

    public List<Archivo> getItemsAvailableSelectOne() {
        return getFacade().findAll();
    }

    @FacesConverter(forClass = Archivo.class)
    public static class ArchivoControllerConverter implements Converter {

        private static final String SEPARATOR = "#";
        private static final String SEPARATOR_ESCAPED = "\\#";

        @Override
        public Object getAsObject(FacesContext facesContext, UIComponent component, String value) {
            if (value == null || value.length() == 0) {
                return null;
            }
            ArchivoController controller = (ArchivoController) facesContext.getApplication().getELResolver().
                    getValue(facesContext.getELContext(), null, "archivoController");
            return controller.getArchivo(getKey(value));
        }

        co.unicauca.proyectobase.entidades.ArchivoPK getKey(String value) {
            co.unicauca.proyectobase.entidades.ArchivoPK key;
            String values[] = value.split(SEPARATOR_ESCAPED);
            key = new co.unicauca.proyectobase.entidades.ArchivoPK();
            key.setArctipoPDFcargar(values[0]);
            key.setDocIdentificador(Integer.parseInt(values[1]));
            return key;
        }

        String getStringKey(co.unicauca.proyectobase.entidades.ArchivoPK value) {
            StringBuilder sb = new StringBuilder();
            sb.append(value.getArctipoPDFcargar());
            sb.append(SEPARATOR);
            sb.append(value.getDocIdentificador());
            return sb.toString();
        }

        @Override
        public String getAsString(FacesContext facesContext, UIComponent component, Object object) {
            if (object == null) {
                return null;
            }
            if (object instanceof Archivo) {
                Archivo o = (Archivo) object;
                return getStringKey(o.getArchivoPK());
            } else {
                Logger.getLogger(this.getClass().getName()).log(Level.SEVERE, "object {0} is of type {1}; expected type: {2}", new Object[]{object, object.getClass().getName(), Archivo.class.getName()});
                return null;
            }
        }

    }

}
