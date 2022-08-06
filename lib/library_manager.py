import PyPDF2
import fitz


def pdf_metadata(pdf_file_path):
    pdf_file = open(pdf_file_path, 'rb')

    pdf_filereader = PyPDF2.PdfFileReader(pdf_file)

    # print the book metadata
    file_name = pdf_file.name
    title = pdf_filereader.metadata.title
    author = pdf_filereader.metadata.author
    num_pages = pdf_filereader.numPages

    book_name = "{} by {} ({}, p {})".format(title, author, '2017', num_pages)
    print("{} => {}".format(file_name, book_name))

    # close the PDF file
    pdf_file.close()


def extract_images(pdf_file_path):
    pdf_file = fitz.open(pdf_file_path)

    # Reading the location where to save the file
    # location = input("Enter the location to save: ")
    location = 'resources'

    # finding number of pages in the pdf
    number_of_pages = len(pdf_file)

    # iterating through each page in the pdf
    for current_page_index in range(number_of_pages):
        # iterating through each image in every page of PDF
        for img_index, img in enumerate(pdf_file.getPageImageList(current_page_index)):
            xref = img[0]
            image = fitz.Pixmap(pdf_file, xref)
            # if it is a is GRAY or RGB image
            if image.n < 5:
                image.writePNG("{}/image{}-{}.png".format(location, current_page_index, img_index))
            # if it is CMYK: convert to RGB first
            else:
                new_image = fitz.Pixmap(fitz.csRGB, image)
                new_image.writePNG("{}/image{}-{}.png".foramt(location, current_page_index, img_index))


if __name__ == '__main__':
    # file_path = input("Enter the PDF file path")
    file_path = 'resources/OAuth 2.pdf'
    pdf_metadata(file_path)
    extract_images(file_path)
