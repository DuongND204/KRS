package models;

public class Config {
    private Integer id;
    private String title;
    private ConfigType type;

    public Config() {
    }

    public Config(Integer id, String title, ConfigType type) {
        this.id = id;
        this.title = title;
        this.type = type;
    }

    //region Getter & Setter

    public Integer getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public ConfigType getType() {
        return type;
    }

    public void setType(ConfigType type) {
        this.type = type;
    }
    //endregion
}
