public class Einstein_Dataset {
    
    public Long id {get; set;}
    public String name {get; set;}
    public DateTime createdAt {get; set;}
    public DateTime updatedAt {get; set;}
    public Einstein_LabelSummary labelSummary {get; set;}
    public Long totalExamples {get; set;}
    public Long totalLabels {get; set;}
    public Boolean available {get; set;}
    public String statusMsg {get; set;}
    public String type {get; set;}

    public enum Types {
        ALL,
        FEEDBACK,
        UPLOAD
    }

}