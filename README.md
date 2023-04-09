Details of every model and working of the system

Every Model when invoked will give its prediction as a number. So, when the model predicts a number, it has some class associated with it i.e., the type of that particular cancer type.
This file contains what each number for that particular type means. These has to be used for displaying the final output since numbers will not be of any use to the user.

    1. Blood Cancer Leukemia – 
{'Acute_Lymphoblastic_Leukemia': 0, 'Chronic_Lymphocytic_Leukemia': 1}

    2. Blood Cancer Lymphoma –
{'Follicular_Lymphoma': 0, 
'Mantle_Cell_Lymphoma': 1}


    3. Brain Cancer Detailed – 
{'brain_glioma': 0, 
'brain_meningioma': 1, 
'brain_no_tumor': 2, 
'brain_pituitary_tumor': 3}


    4. Breast Cancer Histopathology – 
{'breast_benign': 0, 
'breast_malignant': 1}


    5. Breast Cancer pCR – 
{'non-pCR': 0, 
'pCR': 1}


    6. Breast Cancer Ultrasound – 
{'benign': 0, 
'malignant': 1}


    7. Cervical Cancer – 
{'cervix_dyskeratotic': 0, 
'cervix_koilocytotic': 1, 
'cervix_metaplastic': 2, 
'cervix_parabasal': 3, 
'cervix_superficial_intermediat': 4}




    8. Colon Cancer – 
{'colon_adenocarcinoma': 0, 
'colon_benign_tissue': 1}



    9. Kidney Cancer – 
{'kidney_normal': 0, 
'kidney_tumor': 1}


    10. Lung Cancer Histopathology – 
{'lung_adenocarcinoma': 0, 
'lung_benign_tissue': 1, 
'lung_squamous_cell_carcinoma': 2}


    11. Oral Cancer Histopathology – 
{'oral_normal': 0, 
'oral_squamous_cell_carcinoma': 1}

Working – 
    • User will select which type of cancer he/she is suspecting from a drop-down menu.
    • After selection, the conditional statements will be invoked.
    • The control will be sent to the particular type selected.
    • Image will be uploaded which will be sent for prediction.
    • Prediction will be a number and the output displayed will be the corresponding class text of the number.

PLEASE NOTE – 
Our whole system is aimed at assisting new age medical people who rely heavily on technology for primary diagnosis of disease. Therefore, they know what they are diagnosing and so will select accordingly.
The system is not for other common people!
