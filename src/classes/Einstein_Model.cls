public class Einstein_Model {

    public Long datasetId {get; set;}
    public String name {get; set;}
    public String status {get; set;}
    public Decimal progress {get; set;}
    public DateTime createdAt {get; set;}
    public DateTime updatedAt {get; set;}
    public Double learningRate {get; set;}
    public Integer epochs {get; set;}
    public Integer queuePosition {get; set;}
    public String modelId {get; set;}
    public String failureMsg {get; set;}
    public Integer datasetVersionId {get; set;}
    public String modelType {get; set;}
    public String type {get; set;}
    
}